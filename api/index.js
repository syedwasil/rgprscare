const fs = require('fs');
const path = require('path');
const url = require('url');

// Determine database file location (Vercel lambdas have write permissions on /tmp)
const IS_VERCEL = process.env.VERCEL === '1' || Boolean(process.env.AWS_LAMBDA_FUNCTION_NAME);
const DATA_DIR = IS_VERCEL ? path.join('/tmp', 'rgprs_data') : path.join(__dirname, '..', 'admin_portal', 'data');
const DB_FILE = path.join(DATA_DIR, 'db.json');

// Ensure data directory exists
if (!fs.existsSync(DATA_DIR)) {
  try {
    fs.mkdirSync(DATA_DIR, { recursive: true });
  } catch (_) {}
}

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

// Seed or load DB
let db = { ...defaultDb };
function loadDb() {
  if (fs.existsSync(DB_FILE)) {
    try {
      const data = JSON.parse(fs.readFileSync(DB_FILE, 'utf8'));
      db = { ...defaultDb, ...data };
      return;
    } catch (_) {}
  }
  // Try fallback seed
  const seedFile = path.join(__dirname, '..', 'admin_portal', 'data', 'db.json');
  if (fs.existsSync(seedFile)) {
    try {
      const seed = JSON.parse(fs.readFileSync(seedFile, 'utf8'));
      db = { ...defaultDb, ...seed };
      saveDb();
      return;
    } catch (_) {}
  }
  saveDb();
}

function saveDb() {
  try {
    if (!fs.existsSync(DATA_DIR)) {
      fs.mkdirSync(DATA_DIR, { recursive: true });
    }
    fs.writeFileSync(DB_FILE, JSON.stringify(db, null, 2), 'utf8');
  } catch (_) {}
}

loadDb();

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

// Helper to read body stream or use pre-parsed Vercel body
function getRequestBody(req) {
  return new Promise((resolve) => {
    if (req.body && typeof req.body === 'object') {
      return resolve(req.body);
    }
    if (typeof req.body === 'string') {
      try {
        return resolve(JSON.parse(req.body));
      } catch (_) {
        return resolve({});
      }
    }
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        resolve(body ? JSON.parse(body) : {});
      } catch (_) {
        resolve({});
      }
    });
    req.on('error', () => resolve({}));
  });
}

module.exports = async function handler(req, res) {
  loadDb(); // Ensure latest data in serverless environment

  const parsedUrl = url.parse(req.url, true);
  let pathname = parsedUrl.pathname;
  const method = req.method;

  // Normalize path if /api prefix is stripped or present
  if (!pathname.startsWith('/api')) {
    pathname = '/api' + (pathname.startsWith('/') ? pathname : '/' + pathname);
  }

  // Full CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PATCH, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization, Accept');

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
    const payload = await getRequestBody(req);
    const ops = payload.ops || [];
    for (const op of ops) {
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
          voiceBase64: p.voiceBase64 || '',
          hasPhoto: hasPhoto,
          photoBase64: p.photoBase64 || (p.photos && p.photos.length > 0 ? p.photos[0] : ''),
          photos: p.photos || (p.photoBase64 ? [p.photoBase64] : []),
          submittedAt: p.createdAt || new Date().toISOString(),
          slaHoursLeft: 72,
          status: 'Pending',
          assignedLeader: 'Unassigned',
          notes: 'Synced from RGPRS J&K Mobile App'
        });
      }

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
          urgency: b.urgency || 'URGENT',
          status: 'URGENT',
          createdAt: b.createdAt || new Date().toISOString()
        });
      }
    }

    saveDb();
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok', accepted: ops.length }));
    return;
  }

  // --- 3. CSV EXPORTS ---
  if (pathname.startsWith('/api/export/') && method === 'GET') {
    const resource = pathname.replace('/api/export/', '');
    const dbKey = RESOURCE_MAP[resource];
    if (dbKey && db[dbKey]) {
      const items = db[dbKey];
      let csv = '';
      if (items.length > 0) {
        const headers = Object.keys(items[0]);
        csv = headers.join(',') + '\n';
        for (const it of items) {
          csv += headers.map(h => `"${String(it[h] || '').replace(/"/g, '""')}"`).join(',') + '\n';
        }
      }
      res.writeHead(200, {
        'Content-Type': 'text/csv; charset=utf-8',
        'Content-Disposition': `attachment; filename="${resource}_${Date.now()}.csv"`
      });
      res.end(csv);
      return;
    }
  }

  // --- 4. UNIVERSAL CRUD FOR ALL 11 COLLECTIONS ---
  const matchWithId = pathname.match(/^\/api\/([a-z0-9-]+)\/([a-zA-Z0-9_-]+)$/);
  if (matchWithId) {
    const resource = matchWithId[1];
    const id = decodeURIComponent(matchWithId[2]);
    const dbKey = RESOURCE_MAP[resource];

    if (dbKey && db[dbKey]) {
      const list = db[dbKey];
      const index = list.findIndex(item => String(item.id) === String(id));

      if (method === 'GET') {
        if (index === -1) {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Item not found' }));
          return;
        }
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(list[index]));
        return;
      }

      if (method === 'PATCH' || method === 'PUT') {
        if (index === -1) {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Item not found' }));
          return;
        }
        const updates = await getRequestBody(req);
        list[index] = { ...list[index], ...updates };
        saveDb();
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(list[index]));
        return;
      }

      if (method === 'DELETE') {
        if (index === -1) {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Item not found' }));
          return;
        }
        const removed = list.splice(index, 1)[0];
        saveDb();
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, deleted: removed }));
        return;
      }
    }
  }

  // Collection level /api/:resource
  const matchCollection = pathname.match(/^\/api\/([a-z0-9-]+)$/);
  if (matchCollection) {
    const resource = matchCollection[1];
    const dbKey = RESOURCE_MAP[resource];

    if (dbKey && db[dbKey]) {
      if (method === 'GET') {
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(db[dbKey]));
        return;
      }

      if (method === 'POST') {
        const bodyObj = await getRequestBody(req);
        const prefix = ID_PREFIX_MAP[resource] || 'INC-';
        const newId = bodyObj.id || (prefix + Date.now().toString().slice(-6));
        const newItem = {
          ...bodyObj,
          id: newId,
          createdAt: bodyObj.createdAt || new Date().toISOString()
        };
        db[dbKey].unshift(newItem);
        saveDb();
        res.writeHead(201, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(newItem));
        return;
      }
    }
  }

  res.writeHead(404, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'Endpoint not found', path: pathname }));
};

