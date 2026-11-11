const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

const PORT = process.env.PORT || 4040;
const DB_FILE = path.join(__dirname, 'data', 'db.json');

// Ensure data directory exists
if (!fs.existsSync(path.join(__dirname, 'data'))) {
  fs.mkdirSync(path.join(__dirname, 'data'), { recursive: true });
}

// Clean Live Production Data Store (Zero Mock/Demo Records)
const defaultDb = {
  grievances: [],
  petitions: [],
  smartMeters: [],
  snowSos: [],
  sportsKits: [],
  janSunwai: [],
  forestRights: [],
  notices: [],
  members: [],
  bloodSos: [],
  volunteers: []
};

// Load or initialize DB
let db = defaultDb;
if (fs.existsSync(DB_FILE)) {
  try {
    db = JSON.parse(fs.readFileSync(DB_FILE, 'utf8'));
    for (const key of Object.keys(defaultDb)) {
      if (!db[key]) db[key] = defaultDb[key];
    }
  } catch (e) {
    db = defaultDb;
  }
} else {
  fs.writeFileSync(DB_FILE, JSON.stringify(defaultDb, null, 2), 'utf8');
}

function saveDb() {
  fs.writeFileSync(DB_FILE, JSON.stringify(db, null, 2), 'utf8');
}

// Resource to db key mapping
const RESOURCE_MAP = {
  'grievances': 'grievances',
  'petitions': 'petitions',
  'smart-meters': 'smartMeters',
  'snow-sos': 'snowSos',
  'sports-kits': 'sportsKits',
  'jan-sunwai': 'janSunwai',
  'forest-rights': 'forestRights',
  'notices': 'notices',
  'members': 'members',
  'blood-sos': 'bloodSos',
  'volunteers': 'volunteers'
};

const ID_PREFIX_MAP = {
  'grievances': 'GRV-2026-',
  'petitions': 'PET-JK-',
  'smart-meters': 'SME-JK-',
  'snow-sos': 'SNOW-2026-',
  'sports-kits': 'KIT-2026-',
  'jan-sunwai': 'JS-JK-',
  'forest-rights': 'FRA-JK-',
  'notices': 'NTC-JK-',
  'members': 'MEM-JK-26-',
  'blood-sos': 'BLD-JK-',
  'volunteers': 'VOL-JK-'
};

// MIME Types
const MIME_TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.svg': 'image/svg+xml',
  '.mp3': 'audio/mpeg',
  '.m4a': 'audio/mp4',
  '.aac': 'audio/aac',
  '.wav': 'audio/wav',
  '.webm': 'audio/webm'
};

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  const pathname = parsedUrl.pathname;
  const method = req.method;

  // Full CORS headers with DELETE & PUT enabled
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PATCH, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  // --- 1. OVERVIEW KPIS & ANALYTICS ---
  if (pathname === '/api/overview' && method === 'GET') {
    const totalGrievances = (db.grievances || []).length;
    const resolvedGrievances = (db.grievances || []).filter(g => g.status === 'Resolved').length;
    const escalatedGrievances = (db.grievances || []).filter(g => (g.status && g.status.includes('Escalated')) || g.slaHoursLeft <= 0).length;
    const totalPetitions = (db.petitions || []).length;
    const totalSmartMeterDisputes = (db.smartMeters || []).length;
    const activeSnowSos = (db.snowSos || []).filter(s => s.status !== 'RESCUED').length;
    const approvedSportsKits = (db.sportsKits || []).length;
    const upcomingJanSunwais = (db.janSunwai || []).length;
    const tribalFraStays = (db.forestRights || []).length;
    const totalMembers = (db.members || []).length;
    const verifiedMembers = (db.members || []).filter(m => m.status === 'verified').length;
    const pendingPriVerifications = (db.members || []).filter(m => m.status === 'pending').length;
    const totalBloodSos = (db.bloodSos || []).length;
    const activeBloodSos = (db.bloodSos || []).filter(b => b.status === 'URGENT' || b.status === 'PENDING').length;
    const totalVolunteers = (db.volunteers || []).length;

    const categoryCounts = {};
    for (const g of (db.grievances || [])) {
      categoryCounts[g.category] = (categoryCounts[g.category] || 0) + 1;
    }

    const districtCounts = {};
    for (const g of (db.grievances || [])) {
      districtCounts[g.district] = (districtCounts[g.district] || 0) + 1;
    }

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      totalGrievances,
      resolvedGrievances,
      escalatedGrievances,
      totalPetitions,
      totalSmartMeterDisputes,
      activeSnowSos,
      approvedSportsKits,
      upcomingJanSunwais,
      tribalFraStays,
      totalMembers,
      verifiedMembers,
      pendingPriVerifications,
      totalBloodSos,
      activeBloodSos,
      totalVolunteers,
      categoryCounts,
      districtCounts,
      districtsCount: 20,
      timestamp: new Date().toISOString()
    }));
    return;
  }

  // --- 2. MOBILE APP OUTBOX SYNC ---
  if (pathname === '/api/sync' && method === 'POST') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const payload = JSON.parse(body);
        const ops = payload.ops || [];
        for (const op of ops) {
          // A. Grievance
          if (op.entity === 'grievance' && op.payload) {
            const p = op.payload;
            const rawUnit = p.unitId || '';
            const cleanDistrict = rawUnit
              .replace('unit-dist-', '')
              .replace('unit-div-', '')
              .replace('unit-jk', 'Srinagar');
            const formattedDistrict = cleanDistrict.length > 0
              ? cleanDistrict.charAt(0).toUpperCase() + cleanDistrict.slice(1)
              : (p.district || 'Srinagar');

            const desc = p.description || '';
            const hasVoice = desc.includes('🎙️ Voice Note') || Boolean(p.hasVoice);
            const hasPhoto = desc.includes('📸 Photos Attached') || Boolean(p.hasPhoto);

            let voiceSnippet = '';
            if (hasVoice) {
              const match = desc.match(/🎙️ Voice Note: ([^\n]+)/);
              if (match) voiceSnippet = match[1];
            }

            db.grievances.unshift({
              id: p.refCode || op.entityId || 'GRV-2026-' + (db.grievances.length + 81),
              title: p.title || 'Untitled Grievance',
              category: p.category ? (p.category.charAt(0).toUpperCase() + p.category.slice(1)) : 'General',
              district: formattedDistrict,
              tehsil: p.tehsil || '',
              village: p.village || '',
              citizenName: p.reporterName || 'Citizen',
              citizenPhone: p.reporterPhone || 'Anonymous',
              description: desc,
              hasVoice: hasVoice,
              voiceSnippet: voiceSnippet,
              hasPhoto: hasPhoto,
              submittedAt: p.createdAt || new Date().toISOString(),
              slaHoursLeft: 72,
              status: 'Pending',
              assignedLeader: 'Unassigned',
              notes: 'Synced from RGPRS J&K Mobile App'
            });
          }

          // B. Memberships & PRI
          if (op.entity === 'member' && op.payload) {
            const m = op.payload;
            const existingIdx = (db.members || []).findIndex(x => x.memberCode === m.memberCode || (x.phone && x.phone === m.phone));
            const rawUnit = m.unitId || '';
            const cleanDistrict = rawUnit
              .replace('unit-dist-', '')
              .replace('unit-div-', '')
              .replace('unit-jk', 'Srinagar');
            const formattedDistrict = cleanDistrict.length > 0
              ? cleanDistrict.charAt(0).toUpperCase() + cleanDistrict.slice(1)
              : 'Srinagar';

            const isPri = ['panch', 'sarpanch', 'bdc', 'ddc'].includes(m.role);
            const memberObj = {
              id: op.entityId || 'MEM-JK-2026-' + ((db.members ? db.members.length : 0) + 101),
              name: m.name || 'Member',
              phone: m.phone || '9419000000',
              district: formattedDistrict,
              tehsil: 'Panchayat Halqa',
              role: m.role || 'citizen',
              roleTitle: isPri ? `Elected PRI (${(m.role || '').toUpperCase()})` : 'Digital Member & Citizen',
              status: isPri ? 'pending' : 'verified',
              memberCode: m.memberCode || 'INC-JK-26-' + Math.floor(1000 + Math.random() * 9000),
              enrolledAt: m.createdAt ? m.createdAt.split('T')[0] : new Date().toISOString().split('T')[0],
              isElected: isPri,
              gazetteProof: isPri
                ? 'Submitted via RGPRS App - Awaiting District Returning Officer Sign'
                : 'Verified Digital Membership'
            };

            if (!db.members) db.members = [];
            if (existingIdx !== -1) {
              db.members[existingIdx] = { ...db.members[existingIdx], ...memberObj };
            } else {
              db.members.unshift(memberObj);
            }
          }

          // C. Notices
          if (op.entity === 'notice' && op.payload) {
            const n = op.payload;
            if (!db.notices) db.notices = [];
            const exists = db.notices.some(x => x.id === n.id);
            if (!exists) {
              db.notices.unshift({
                id: n.id || 'NTC-JK-' + (db.notices.length + 501),
                title: n.title,
                body: n.body,
                priority: n.priority || 'normal',
                authorName: n.authorName || 'RGPRS App Broadcast',
                createdAt: n.createdAt || new Date().toISOString()
              });
            }
          }

          // D. Blood SOS
          if (op.entity === 'blood-sos' && op.payload) {
            const b = op.payload;
            if (!db.bloodSos) db.bloodSos = [];
            db.bloodSos.unshift({
              id: b.id || 'BLD-JK-' + (db.bloodSos.length + 101),
              patientName: b.patientName || 'Anonymous Patient',
              bloodGroup: b.bloodGroup || 'O+',
              unitsNeeded: b.unitsNeeded || 1,
              hospitalName: b.hospitalName || 'District Hospital',
              district: b.district || 'Srinagar',
              contactPhone: b.contactPhone || '',
              urgency: b.urgency || 'CRITICAL',
              status: b.status || 'URGENT',
              matchedDonor: b.matchedDonor || 'Awaiting Donor Matching',
              createdAt: b.createdAt || new Date().toISOString()
            });
          }

          // E. Volunteers
          if (op.entity === 'volunteer' && op.payload) {
            const v = op.payload;
            if (!db.volunteers) db.volunteers = [];
            db.volunteers.unshift({
              id: v.id || 'VOL-JK-' + (db.volunteers.length + 101),
              name: v.name || 'Volunteer',
              phone: v.phone || '',
              district: v.district || 'Srinagar',
              bloodGroup: v.bloodGroup || 'A+',
              wing: v.wing || 'Congress Seva Dal Brigade',
              status: v.status || 'Active',
              assignedTasks: v.assignedTasks || 'Emergency & Health Support',
              enrolledAt: v.enrolledAt || new Date().toISOString().split('T')[0]
            });
          }
        }
        saveDb();
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ accepted: ops.length }));
      } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Sync failed: ' + e.message }));
      }
    });
    return;
  }

  // --- 3. CSV EXPORT ENDPOINT ---
  if (pathname.startsWith('/api/export/')) {
    const type = pathname.split('/')[3];
    if (type === 'grievances') {
      const header = 'ID,Citizen Name,Phone,District,Tehsil,Village,Category,Title,SLA Hours Left,Status\n';
      const rows = db.grievances.map(g =>
        `"${g.id}","${g.citizenName}","${g.citizenPhone}","${g.district}","${g.tehsil}","${g.village}","${g.category}","${(g.title || '').replace(/"/g, '""')}",${g.slaHoursLeft},"${g.status}"`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="RGPRS_JK_Grievances_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
    if (type === 'petitions') {
      const header = 'ID,Name,Phone,District,Qualification,Demand,Date\n';
      const rows = db.petitions.map(p =>
        `"${p.id}","${p.name}","${p.phone}","${p.district}","${p.qualification}","${(p.demand || '').replace(/"/g, '""')}","${p.date}"`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="1_Lakh_Vacancy_Petitions_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
    if (type === 'smart-meters') {
      const header = 'ID,Consumer Name,PDD Account No,District,Units Billed,Amount Billed,Legitimate Tariff,Overcharge Discrepancy,Status,Date\n';
      const rows = db.smartMeters.map(m =>
        `"${m.id}","${m.consumerName}","${m.consumerNo}","${m.district}",${m.unitsBilled},${m.amountCharged},${m.legitimateTariff},${m.discrepancy},"${m.status}","${m.date}"`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="Smart_Meter_Disputes_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
    if (type === 'snow-sos') {
      const header = 'ID,Patient Name,Attendant Phone,District,Pass Area,Distance To Road,Status,Squad Captain\n';
      const rows = db.snowSos.map(s =>
        `"${s.id}","${s.patientName}","${s.attendantPhone}","${s.district}","${s.passArea}","${s.distanceToRoad}","${s.status}","${s.squadCaptain}"`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="Snow_Emergency_SOS_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
    if (type === 'sports-kits') {
      const header = 'ID,Youth Club,Captain Name,Phone,Halqa Panchayat,District,Kit Type,Status\n';
      const rows = db.sportsKits.map(k =>
        `"${k.id}","${k.clubName}","${k.captainName}","${k.captainPhone}","${k.panchayat}","${k.district}","${k.kitType}","${k.status}"`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="Youth_Sports_Kits_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
    if (type === 'jan-sunwai') {
      const header = 'ID,District,Venue,Date,Time,Leaders,Focus Areas,Coordinator Phone,Slots Booked\n';
      const rows = db.janSunwai.map(js =>
        `"${js.id}","${js.district}","${js.venue}","${js.date}","${js.time || ''}","${js.leaders}","${js.focusAreas}","${js.coordinatorPhone}",${js.slotsBooked || 0}`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="Jan_Sunwai_Hearings_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
    if (type === 'forest-rights') {
      const header = 'ID,Claimant Name,Tribal Clan,District,Forest Range,Kotha Location,Status,Date Filed\n';
      const rows = db.forestRights.map(f =>
        `"${f.id}","${f.claimant}","${f.clan}","${f.district}","${f.forestRange}","${f.kothaLocation}","${f.status}","${f.filedAt}"`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="Forest_Rights_Stays_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
    if (type === 'members') {
      const header = 'Member Code,Full Name,Phone,District,Tehsil,Role,Status,Enrolled Date,Gazette Proof\n';
      const rows = (db.members || []).map(m =>
        `"${m.memberCode}","${m.name}","${m.phone}","${m.district}","${m.tehsil}","${m.role}","${m.status}","${m.enrolledAt}","${(m.gazetteProof || '').replace(/"/g, '""')}"`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="INC_RGPRS_Members_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
    if (type === 'blood-sos') {
      const header = 'ID,Patient Name,Blood Group,Units Needed,Hospital Name,District,Contact Phone,Urgency,Status,Matched Donor,Date\n';
      const rows = (db.bloodSos || []).map(b =>
        `"${b.id}","${b.patientName}","${b.bloodGroup}",${b.unitsNeeded},"${b.hospitalName}","${b.district}","${b.contactPhone}","${b.urgency}","${b.status}","${b.matchedDonor}","${b.createdAt}"`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="Blood_SOS_Requests_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
    if (type === 'volunteers') {
      const header = 'ID,Full Name,Phone,District,Blood Group,Wing,Status,Assigned Tasks,Enrolled Date\n';
      const rows = (db.volunteers || []).map(v =>
        `"${v.id}","${v.name}","${v.phone}","${v.district}","${v.bloodGroup}","${v.wing}","${v.status}","${(v.assignedTasks || '').replace(/"/g, '""')}","${v.enrolledAt}"`
      ).join('\n');
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': 'attachment; filename="Congress_Seva_Dal_Volunteers_' + Date.now() + '.csv"'
      });
      res.end(header + rows);
      return;
    }
  }

  // --- 4. UNIVERSAL CRUD ROUTER FOR ALL 11 ENTITIES ---
  // Matches /api/<resource> and /api/<resource>/<id>
  const apiMatch = pathname.match(/^\/api\/([a-zA-Z0-9_-]+)(?:\/([a-zA-Z0-9_.-]+))?$/);
  if (apiMatch) {
    const resource = apiMatch[1];
    const itemId = apiMatch[2];
    const collectionKey = RESOURCE_MAP[resource];

    if (collectionKey && db[collectionKey]) {
      // A. DELETE /api/<resource>/:id -> Full delete access!
      if (method === 'DELETE' && itemId) {
        const idx = db[collectionKey].findIndex(x => (x.id && x.id === itemId) || (x.memberCode && x.memberCode === itemId));
        if (idx === -1) {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: `${resource} record with id ${itemId} not found` }));
          return;
        }
        const deletedItem = db[collectionKey].splice(idx, 1)[0];
        saveDb();
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, deleted: deletedItem }));
        return;
      }

      // B. PATCH or PUT /api/<resource>/:id -> Full edit access for ANY fields!
      if ((method === 'PATCH' || method === 'PUT') && itemId) {
        let body = '';
        req.on('data', chunk => body += chunk);
        req.on('end', () => {
          const idx = db[collectionKey].findIndex(x => (x.id && x.id === itemId) || (x.memberCode && x.memberCode === itemId));
          if (idx === -1) {
            res.writeHead(404, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ error: `${resource} record with id ${itemId} not found` }));
            return;
          }
          try {
            const updates = JSON.parse(body);
            db[collectionKey][idx] = { ...db[collectionKey][idx], ...updates };
            saveDb();
            res.writeHead(200, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify(db[collectionKey][idx]));
          } catch (e) {
            res.writeHead(400, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ error: 'Invalid update JSON: ' + e.message }));
          }
        });
        return;
      }

      // C. POST /api/<resource> -> Add / create new entry
      if (method === 'POST' && !itemId) {
        let body = '';
        req.on('data', chunk => body += chunk);
        req.on('end', () => {
          try {
            const item = JSON.parse(body);
            const prefix = ID_PREFIX_MAP[resource] || 'JK-';
            item.id = item.id || (prefix + (db[collectionKey].length + 101));
            item.createdAt = item.createdAt || new Date().toISOString();
            if (resource === 'grievances') {
              item.slaHoursLeft = item.slaHoursLeft !== undefined ? item.slaHoursLeft : 72;
              item.status = item.status || 'Pending';
            }
            if (resource === 'notices') {
              item.priority = item.priority || 'normal';
            }
            if (resource === 'members') {
              item.memberCode = item.memberCode || ('INC-JK-26-' + Math.floor(1000 + Math.random() * 9000));
              item.status = item.status || 'verified';
            }
            db[collectionKey].unshift(item);
            saveDb();
            res.writeHead(201, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify(item));
          } catch (e) {
            res.writeHead(400, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ error: 'Invalid create payload: ' + e.message }));
          }
        });
        return;
      }

      // D. GET /api/<resource> -> List items (with query filtering)
      if (method === 'GET' && !itemId) {
        let results = db[collectionKey] || [];
        const districtFilter = parsedUrl.query.district;
        const statusFilter = parsedUrl.query.status;
        const groupFilter = parsedUrl.query.bloodGroup;
        const roleFilter = parsedUrl.query.role;

        if (districtFilter && districtFilter !== 'All') {
          results = results.filter(x => (x.district || '').toLowerCase() === districtFilter.toLowerCase());
        }
        if (statusFilter && statusFilter !== 'All') {
          results = results.filter(x => (x.status || '').toLowerCase() === statusFilter.toLowerCase());
        }
        if (groupFilter && groupFilter !== 'All') {
          results = results.filter(x => (x.bloodGroup || '').toLowerCase() === groupFilter.toLowerCase());
        }
        if (roleFilter && roleFilter !== 'All') {
          results = results.filter(x => (x.role || '').toLowerCase() === roleFilter.toLowerCase());
        }

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(results));
        return;
      }
    }
  }

  // --- 5. STATIC WEB ASSETS ---
  let filePath = path.join(__dirname, 'public', pathname === '/' ? 'index.html' : pathname);
  const ext = path.extname(filePath);

  fs.readFile(filePath, (err, content) => {
    if (err) {
      if (err.code === 'ENOENT') {
        fs.readFile(path.join(__dirname, 'public', 'index.html'), (err2, fallback) => {
          if (err2) {
            res.writeHead(404, { 'Content-Type': 'text/plain' });
            res.end('404 Not Found');
          } else {
            res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
            res.end(fallback);
          }
        });
      } else {
        res.writeHead(500);
        res.end(`Server Error: ${err.code}`);
      }
    } else {
      res.writeHead(200, { 'Content-Type': MIME_TYPES[ext] || 'application/octet-stream' });
      res.end(content);
    }
  });
});

server.listen(PORT, () => {
  console.log(`================================================================`);
  console.log(`RGPRS & INC J&K Citizen Care Web Control Room`);
  console.log(`Full CRUD & Delete Access Enabled at: http://localhost:${PORT}`);
  console.log(`REST APIs: http://localhost:${PORT}/api/overview`);
  console.log(`================================================================`);
});
