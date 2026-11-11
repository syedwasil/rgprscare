// RGPRS & Indian National Congress (INC) Jammu & Kashmir
// Central Citizen Care Web Control Room - Client App
// Full CRUD: Edit, Delete, Create & Live App Sync Enabled

let categoryChartInstance = null;
let districtChartInstance = null;

// Cache of all live records
const store = {
  'grievances': [],
  'blood-sos': [],
  'volunteers': [],
  'petitions': [],
  'smart-meters': [],
  'jan-sunwai': [],
  'snow-sos': [],
  'forest-rights': [],
  'sports-kits': [],
  'notices': [],
  'members': []
};

// Currently editing item reference
let currentEditResource = null;
let currentEditId = null;
let currentAddResource = null;

// Tab Navigation
document.querySelectorAll('.nav-item').forEach(button => {
  button.addEventListener('click', () => {
    document.querySelectorAll('.nav-item').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));

    button.classList.add('active');
    const tabId = button.getAttribute('data-tab');
    const targetPane = document.getElementById(tabId);
    if (targetPane) {
      targetPane.classList.add('active');
    }

    const titles = {
      'tab-overview': 'Live Citizen Care Dashboard',
      'tab-grievances': 'Grievance Control & Redressal Desk',
      'tab-blood': 'Emergency Blood SOS & Life-Saving Desk',
      'tab-volunteers': 'Congress Seva Dal & Youth Brigade Roster',
      'tab-petitions': '1-Lakh Vacancy Youth Assembly Petitions',
      'tab-meters': 'Smart Meter Billing Dispute Appeals',
      'tab-jansunwai': 'Village Jan Sunwai Public Hearing Calendar',
      'tab-snow': 'Chilla-i-Kalan Snow Emergency Dispatch Desk',
      'tab-fra': 'Forest Rights Act (FRA 2006) Tribal Eviction Stays',
      'tab-sports': 'Rajiv Gandhi Youth Sports Swaraj Kits',
      'tab-notices': 'Official Broadcast Circulars & Bulletins',
      'tab-members': 'Verified Digital Membership & PRI Elected Registry'
    };
    document.getElementById('page-title').innerText = titles[tabId] || 'Citizen Care Control Room';

    refreshTab(tabId);
  });
});

function refreshCurrentTab() {
  const activeTab = document.querySelector('.nav-item.active');
  const tabId = activeTab ? activeTab.getAttribute('data-tab') : 'tab-overview';
  refreshTab(tabId);
}

function refreshTab(tabId) {
  if (tabId === 'tab-overview') loadOverview();
  if (tabId === 'tab-grievances') loadGrievances();
  if (tabId === 'tab-blood') loadBloodSos();
  if (tabId === 'tab-volunteers') loadVolunteers();
  if (tabId === 'tab-petitions') loadPetitions();
  if (tabId === 'tab-meters') loadSmartMeters();
  if (tabId === 'tab-jansunwai') loadJanSunwai();
  if (tabId === 'tab-snow') loadSnowSos();
  if (tabId === 'tab-fra') loadForestRights();
  if (tabId === 'tab-sports') loadSportsKits();
  if (tabId === 'tab-notices') loadNotices();
  if (tabId === 'tab-members') loadMembers();
}

// Full Unfettered Admin Access (No blocking PIN)
function verifyAdminPin() {
  return true;
}

// ----------------------------------------------------
// UNIVERSAL DELETE HANDLER
// ----------------------------------------------------
async function deleteRecord(resource, id) {
  if (!confirm(`⚠️ Confirm Deletion: Are you sure you want to permanently delete record ${id}?`)) {
    return;
  }

  try {
    const res = await fetch(`/api/${resource}/${id}`, {
      method: 'DELETE'
    });

    if (res.ok) {
      // Remove from memory
      if (store[resource]) {
        store[resource] = store[resource].filter(x => (x.id || x.memberCode) !== id);
      }
      loadOverview();
      refreshCurrentTab();
    } else {
      const err = await res.json().catch(() => ({}));
      alert(`Delete failed: ${err.error || 'Server rejected request'}`);
    }
  } catch (err) {
    alert(`Connection error while deleting: ${err.message}`);
  }
}

// ----------------------------------------------------
// UNIVERSAL EDIT MODAL
// ----------------------------------------------------
const FIELD_DEFINITIONS = {
  'grievances': [
    { key: 'title', label: 'Title / Subject', type: 'text' },
    { key: 'category', label: 'Category', type: 'select', options: ['Water', 'Electricity', 'Road', 'Rations', 'MGNREGA', 'Pension', 'Health', 'General'] },
    { key: 'district', label: 'District', type: 'select', options: ['Srinagar', 'Anantnag', 'Baramulla', 'Budgam', 'Pulwama', 'Kupwara', 'Shopian', 'Ganderbal', 'Kulgam', 'Bandipora', 'Jammu', 'Udhampur', 'Kathua', 'Rajouri', 'Poonch', 'Doda', 'Ramban', 'Kishtwar', 'Samba', 'Reasi'] },
    { key: 'tehsil', label: 'Tehsil / Halqa', type: 'text' },
    { key: 'citizenName', label: 'Citizen Name', type: 'text' },
    { key: 'citizenPhone', label: 'Citizen Phone', type: 'tel' },
    { key: 'status', label: 'Status', type: 'select', options: ['Pending', 'In Progress', 'Resolved', 'Escalated'] },
    { key: 'slaHoursLeft', label: 'SLA Hours Left', type: 'number' },
    { key: 'assignedLeader', label: 'Assigned Leader / Block President', type: 'text' },
    { key: 'notes', label: 'Resolution Action Notes', type: 'textarea' },
    { key: 'description', label: 'Full Description', type: 'textarea' }
  ],
  'blood-sos': [
    { key: 'patientName', label: 'Patient Name', type: 'text' },
    { key: 'bloodGroup', label: 'Blood Group', type: 'select', options: ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'] },
    { key: 'unitsNeeded', label: 'Units Needed', type: 'number' },
    { key: 'hospitalName', label: 'Hospital Name', type: 'text' },
    { key: 'district', label: 'District', type: 'text' },
    { key: 'contactPhone', label: 'Attendant Contact Phone', type: 'tel' },
    { key: 'urgency', label: 'Urgency', type: 'select', options: ['CRITICAL', 'URGENT', 'STANDARD'] },
    { key: 'status', label: 'Status', type: 'select', options: ['URGENT', 'DONOR FOUND', 'RESOLVED'] },
    { key: 'matchedDonor', label: 'Matched Donor Details', type: 'text' }
  ],
  'volunteers': [
    { key: 'name', label: 'Volunteer Full Name', type: 'text' },
    { key: 'phone', label: 'Mobile Number', type: 'tel' },
    { key: 'district', label: 'District', type: 'text' },
    { key: 'bloodGroup', label: 'Blood Group', type: 'select', options: ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'] },
    { key: 'wing', label: 'Wing / Unit', type: 'text' },
    { key: 'assignedTasks', label: 'Assigned Seva Tasks', type: 'text' },
    { key: 'status', label: 'Status', type: 'select', options: ['Active', 'On Call', 'Inactive'] }
  ],
  'petitions': [
    { key: 'name', label: 'Applicant Name', type: 'text' },
    { key: 'phone', label: 'Phone Number', type: 'tel' },
    { key: 'district', label: 'District', type: 'text' },
    { key: 'qualification', label: 'Qualification', type: 'text' },
    { key: 'demand', label: 'Demand / Appeal', type: 'textarea' }
  ],
  'smart-meters': [
    { key: 'consumerName', label: 'Consumer Name', type: 'text' },
    { key: 'consumerNo', label: 'PDD Account No', type: 'text' },
    { key: 'district', label: 'District', type: 'text' },
    { key: 'unitsBilled', label: 'Units Billed', type: 'number' },
    { key: 'amountCharged', label: 'Amount Charged (₹)', type: 'number' },
    { key: 'legitimateTariff', label: 'Fair Tariff (₹)', type: 'number' },
    { key: 'discrepancy', label: 'Overcharge Discrepancy (₹)', type: 'number' },
    { key: 'status', label: 'Appeal Status', type: 'select', options: ['Representation Filed with Control Room', 'Notice Served to PDD', 'Tariff Surcharge Stayed', 'Resolved'] }
  ],
  'jan-sunwai': [
    { key: 'district', label: 'District', type: 'text' },
    { key: 'venue', label: 'Venue Location', type: 'text' },
    { key: 'date', label: 'Hearing Date (YYYY-MM-DD)', type: 'date' },
    { key: 'time', label: 'Time Slot', type: 'text' },
    { key: 'leaders', label: 'Attending Party Leaders', type: 'text' },
    { key: 'focusAreas', label: 'Focus Civic Areas', type: 'text' },
    { key: 'coordinatorPhone', label: 'Coordinator Helpline Phone', type: 'tel' },
    { key: 'slotsBooked', label: 'Slots Booked', type: 'number' }
  ],
  'snow-sos': [
    { key: 'patientName', label: 'Patient Name', type: 'text' },
    { key: 'attendantPhone', label: 'Attendant Phone', type: 'tel' },
    { key: 'district', label: 'District', type: 'text' },
    { key: 'passArea', label: 'Pass / Isolated Area', type: 'text' },
    { key: 'distanceToRoad', label: 'Distance to Motor Road', type: 'text' },
    { key: 'status', label: 'Status', type: 'select', options: ['DISPATCHED', 'STRETCHER EN ROUTE', 'RESCUED'] },
    { key: 'squadCaptain', label: 'Squad Captain / Contact', type: 'text' }
  ],
  'forest-rights': [
    { key: 'claimant', label: 'Claimant Name', type: 'text' },
    { key: 'clan', label: 'Tribal Clan', type: 'text' },
    { key: 'district', label: 'District', type: 'text' },
    { key: 'forestRange', label: 'Forest Range', type: 'text' },
    { key: 'kothaLocation', label: 'Kotha / Dhok Location', type: 'text' },
    { key: 'status', label: 'Legal Shield Status', type: 'select', options: ['Eviction Stay Granted', 'Under Review at DLC', 'Representation Filed'] }
  ],
  'sports-kits': [
    { key: 'clubName', label: 'Youth Club Name', type: 'text' },
    { key: 'captainName', label: 'Captain Name', type: 'text' },
    { key: 'captainPhone', label: 'Captain Phone', type: 'tel' },
    { key: 'panchayat', label: 'Halqa Panchayat', type: 'text' },
    { key: 'district', label: 'District', type: 'text' },
    { key: 'kitType', label: 'Kit Requested', type: 'text' },
    { key: 'status', label: 'Dispatch Status', type: 'select', options: ['Requested', 'Approved by DCC', 'Dispatched to Halqa', 'Delivered'] }
  ],
  'notices': [
    { key: 'title', label: 'Circular Title', type: 'text' },
    { key: 'priority', label: 'Priority', type: 'select', options: ['normal', 'high', 'critical'] },
    { key: 'authorName', label: 'Issuing Desk / Author', type: 'text' },
    { key: 'body', label: 'Notice Content', type: 'textarea' }
  ],
  'members': [
    { key: 'name', label: 'Member Full Name', type: 'text' },
    { key: 'phone', label: 'Phone Number', type: 'tel' },
    { key: 'district', label: 'District', type: 'text' },
    { key: 'tehsil', label: 'Tehsil / Halqa', type: 'text' },
    { key: 'role', label: 'Role', type: 'select', options: ['citizen', 'sarpanch', 'panch', 'bdc', 'ddc'] },
    { key: 'status', label: 'Verification Status', type: 'select', options: ['verified', 'pending'] },
    { key: 'gazetteProof', label: 'Verification Proof / Notes', type: 'text' }
  ]
};

function openEditModal(resource, id) {
  currentEditResource = resource;
  currentEditId = id;

  const items = store[resource] || [];
  const item = items.find(x => (x.id || x.memberCode) === id);
  if (!item) {
    alert(`Record ${id} not found.`);
    return;
  }

  document.getElementById('edit-modal-title').innerText = `✏️ Edit ${resource.toUpperCase()} (${id})`;
  const container = document.getElementById('edit-modal-body');
  const fields = FIELD_DEFINITIONS[resource] || [];

  container.innerHTML = fields.map(f => {
    const val = item[f.key] !== undefined ? item[f.key] : '';
    if (f.type === 'select') {
      const opts = (f.options || []).map(opt => `<option value="${opt}" ${String(val).toLowerCase() === opt.toLowerCase() ? 'selected' : ''}>${opt}</option>`).join('');
      return `
        <label>${f.label}:
          <select id="edit-field-${f.key}" class="neo-input">${opts}</select>
        </label>
      `;
    }
    if (f.type === 'textarea') {
      return `
        <label>${f.label}:
          <textarea id="edit-field-${f.key}" class="neo-input" rows="3">${val}</textarea>
        </label>
      `;
    }
    return `
      <label>${f.label}:
        <input type="${f.type}" id="edit-field-${f.key}" class="neo-input" value="${val}">
      </label>
    `;
  }).join('');

  document.getElementById('modal-universal-edit').classList.add('active');
}

function closeUniversalEditModal() {
  document.getElementById('modal-universal-edit').classList.remove('active');
  currentEditResource = null;
  currentEditId = null;
}

async function submitUniversalEdit() {
  if (!currentEditResource || !currentEditId) return;

  const fields = FIELD_DEFINITIONS[currentEditResource] || [];
  const updates = {};
  for (const f of fields) {
    const el = document.getElementById(`edit-field-${f.key}`);
    if (el) {
      updates[f.key] = f.type === 'number' ? (Number(el.value) || 0) : el.value.trim();
    }
  }

  try {
    const res = await fetch(`/api/${currentEditResource}/${currentEditId}`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(updates)
    });

    if (res.ok) {
      closeUniversalEditModal();
      loadOverview();
      refreshCurrentTab();
    } else {
      const err = await res.json().catch(() => ({}));
      alert(`Update failed: ${err.error || 'Server rejected changes'}`);
    }
  } catch (err) {
    alert(`Network error saving update: ${err.message}`);
  }
}

// ----------------------------------------------------
// UNIVERSAL ADD MODAL
// ----------------------------------------------------
function openAddModal(resource) {
  currentAddResource = resource;
  document.getElementById('add-modal-title').innerText = `➕ Add New ${resource.toUpperCase()}`;
  const container = document.getElementById('add-modal-body');
  const fields = FIELD_DEFINITIONS[resource] || [];

  container.innerHTML = fields.map(f => {
    if (f.type === 'select') {
      const opts = (f.options || []).map(opt => `<option value="${opt}">${opt}</option>`).join('');
      return `
        <label>${f.label}:
          <select id="add-field-${f.key}" class="neo-input">${opts}</select>
        </label>
      `;
    }
    if (f.type === 'textarea') {
      return `
        <label>${f.label}:
          <textarea id="add-field-${f.key}" class="neo-input" rows="3" placeholder="Enter ${f.label.toLowerCase()}..."></textarea>
        </label>
      `;
    }
    return `
      <label>${f.label}:
        <input type="${f.type}" id="add-field-${f.key}" class="neo-input" placeholder="Enter ${f.label.toLowerCase()}...">
      </label>
    `;
  }).join('');

  document.getElementById('modal-universal-add').classList.add('active');
}

function closeUniversalAddModal() {
  document.getElementById('modal-universal-add').classList.remove('active');
  currentAddResource = null;
}

async function submitUniversalAdd() {
  if (!currentAddResource) return;

  const fields = FIELD_DEFINITIONS[currentAddResource] || [];
  const payload = {};
  for (const f of fields) {
    const el = document.getElementById(`add-field-${f.key}`);
    if (el) {
      payload[f.key] = f.type === 'number' ? (Number(el.value) || 0) : el.value.trim();
    }
  }

  try {
    const res = await fetch(`/api/${currentAddResource}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });

    if (res.ok) {
      closeUniversalAddModal();
      loadOverview();
      refreshCurrentTab();
    } else {
      const err = await res.json().catch(() => ({}));
      alert(`Creation failed: ${err.error || 'Server error'}`);
    }
  } catch (err) {
    alert(`Network error creating record: ${err.message}`);
  }
}

// ----------------------------------------------------
// 1. OVERVIEW & CHARTS
// ----------------------------------------------------
async function loadOverview() {
  try {
    const res = await fetch('/api/overview');
    if (!res.ok) throw new Error('API offline');
    const data = await res.json();

    document.getElementById('kpi-total-grievances').innerText = data.totalGrievances || 0;
    document.getElementById('kpi-resolved-grievances').innerText = data.resolvedGrievances || 0;
    document.getElementById('kpi-escalated-grievances').innerText = data.escalatedGrievances || 0;
    document.getElementById('kpi-petitions').innerText = data.totalPetitions || 0;
    document.getElementById('kpi-meters').innerText = data.totalSmartMeterDisputes || 0;
    document.getElementById('kpi-snow').innerText = data.activeSnowSos || 0;
    document.getElementById('kpi-blood-sos').innerText = data.activeBloodSos || 0;
    document.getElementById('kpi-volunteers').innerText = data.totalVolunteers || 0;
    document.getElementById('kpi-members').innerText = data.totalMembers || 0;

    renderCharts(data.categoryCounts, data.districtCounts);
  } catch (err) {
    console.warn('Overview API fetch error:', err);
  }
}

function renderCharts(categoryCounts, districtCounts) {
  if (typeof Chart === 'undefined') return;

  const catCanvas = document.getElementById('categoryChart');
  if (catCanvas) {
    const catLabels = Object.keys(categoryCounts || {});
    const catData = Object.values(categoryCounts || {});

    if (categoryChartInstance) categoryChartInstance.destroy();

    categoryChartInstance = new Chart(catCanvas, {
      type: 'doughnut',
      data: {
        labels: catLabels.length ? catLabels : ['Awaiting Live Submissions'],
        datasets: [{
          data: catData.length ? catData : [0],
          backgroundColor: ['#135A91', '#FF9933', '#138808', '#E65100', '#0288D1', '#7B1FA2', '#00796B', '#C2185B'],
          borderWidth: 2,
          borderColor: '#EBF0F7'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: 'bottom', labels: { boxWidth: 12, font: { family: 'Plus Jakarta Sans', weight: '700' } } }
        }
      }
    });
  }

  const distCanvas = document.getElementById('districtChart');
  if (distCanvas) {
    const distLabels = Object.keys(districtCounts || {});
    const distData = Object.values(districtCounts || {});

    if (districtChartInstance) districtChartInstance.destroy();

    districtChartInstance = new Chart(distCanvas, {
      type: 'bar',
      data: {
        labels: distLabels.length ? distLabels : ['No active reports yet'],
        datasets: [{
          label: 'Complaints Logged',
          data: distData.length ? distData : [0],
          backgroundColor: '#135A91',
          borderRadius: 6
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: {
          y: { beginAtZero: true, ticks: { precision: 0, font: { family: 'Plus Jakarta Sans', weight: '700' } }, grid: { color: 'rgba(163, 177, 198, 0.25)' } },
          x: { ticks: { font: { family: 'Plus Jakarta Sans', weight: '700' } }, grid: { display: false } }
        }
      }
    });
  }
}

// ----------------------------------------------------
// 2. GRIEVANCES
// ----------------------------------------------------
async function loadGrievances() {
  try {
    const res = await fetch('/api/grievances');
    store['grievances'] = await res.json();
    filterGrievances();
  } catch (err) {
    console.error('Failed to load grievances:', err);
  }
}

function filterGrievances() {
  const dist = document.getElementById('filter-district').value;
  const stat = document.getElementById('filter-status').value;

  let list = store['grievances'] || [];
  if (dist !== 'All') {
    list = list.filter(g => (g.district || '').toLowerCase() === dist.toLowerCase());
  }
  if (stat !== 'All') {
    list = list.filter(g => (g.status || '').toLowerCase() === stat.toLowerCase());
  }

  const tbody = document.querySelector('#table-grievances tbody');
  if (list.length === 0) {
    tbody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
      No grievances registered yet under selected filters. Click "+ New Grievance" or submit via mobile app.
    </td></tr>`;
    return;
  }

  tbody.innerHTML = list.map(g => {
    let statusClass = 'yellow';
    if (g.status === 'Resolved') statusClass = 'green';
    if (g.status && g.status.includes('Escalated')) statusClass = 'red';
    if (g.status === 'In Progress') statusClass = 'blue';

    const slaClass = (g.slaHoursLeft <= 24) ? 'text-red' : '';

    let attachmentsHtml = '<span style="color:var(--muted-ink); font-size:11px;">None</span>';
    const hasVoice = g.hasVoice || g.voiceBase64 || (g.description && g.description.includes('🎙️ Voice Note'));
    const hasPhoto = g.hasPhoto || g.photoBase64 || (g.photos && g.photos.length > 0) || (g.description && g.description.includes('📸 Photos Attached'));

    if (hasVoice || hasPhoto) {
      attachmentsHtml = '<div style="display:flex; gap:6px; flex-wrap:wrap;">';
      if (hasVoice) {
        attachmentsHtml += `<button class="attachment-pill voice" onclick="playVoiceAudio('${g.id}', '${encodeURIComponent(g.voiceSnippet || 'Audio Statement Attached')}', '${encodeURIComponent(g.voiceBase64 || '')}')">🎙️ Voice Note</button>`;
      }
      if (hasPhoto) {
        const pData = g.photoBase64 || (g.photos && g.photos.length > 0 ? g.photos[0] : '');
        attachmentsHtml += `<button class="attachment-pill photo" onclick="viewPhotoEvidence('${g.id}', '${encodeURIComponent(g.title || '')}', '${encodeURIComponent(pData)}')">📸 Photos</button>`;
      }
      attachmentsHtml += '</div>';
    }

    return `
      <tr>
        <td><strong>${g.id}</strong></td>
        <td>
          <div style="font-weight:800; color:var(--ink);">${g.citizenName || 'Citizen'}</div>
          <a href="tel:${g.citizenPhone}" style="color:var(--party-blue); text-decoration:none; font-size:11.5px; font-weight:700;">📞 ${g.citizenPhone}</a>
        </td>
        <td>
          <strong>${g.district}</strong>
          ${g.tehsil ? `<div style="font-size:11px; color:var(--muted-ink);">${g.tehsil}</div>` : ''}
        </td>
        <td>
          <span class="badge blue">${g.category || 'General'}</span>
          <div style="font-size:12px; margin-top:3px; max-width:220px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="${g.title}">
            ${g.title}
          </div>
        </td>
        <td>${attachmentsHtml}</td>
        <td><strong class="${slaClass}">${g.slaHoursLeft}h left</strong></td>
        <td><span class="badge ${statusClass}">${g.status}</span></td>
        <td>
          <div class="actions-cell">
            <button class="btn-icon-edit" title="Edit this Grievance" onclick="openEditModal('grievances', '${g.id}')">✏️ Edit</button>
            <button class="btn-icon-del" title="Delete this Grievance" onclick="deleteRecord('grievances', '${g.id}')">🗑️ Delete</button>
          </div>
        </td>
      </tr>
    `;
  }).join('');
}

// ----------------------------------------------------
// 3. BLOOD SOS
// ----------------------------------------------------
async function loadBloodSos() {
  try {
    const res = await fetch('/api/blood-sos');
    store['blood-sos'] = await res.json();
    const group = document.getElementById('filter-blood-group').value;

    let list = store['blood-sos'] || [];
    if (group !== 'All') {
      list = list.filter(b => (b.bloodGroup || '').toLowerCase() === group.toLowerCase());
    }

    const tbody = document.querySelector('#table-blood tbody');
    if (list.length === 0) {
      tbody.innerHTML = `<tr><td colspan="9" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
        No emergency blood SOS requests active. Connected in real-time with J&K district hospitals.
      </td></tr>`;
      return;
    }

    tbody.innerHTML = list.map(b => {
      const isUrgent = b.status === 'URGENT' || b.status === 'CRITICAL';
      const statusBadge = isUrgent ? '<span class="badge red">🚨 URGENT</span>' : '<span class="badge green">✅ DONOR FOUND</span>';

      return `
        <tr>
          <td><strong>${b.id}</strong></td>
          <td><strong style="color:var(--ink);">${b.patientName}</strong></td>
          <td>
            <span style="display:inline-block; padding:4px 10px; border-radius:8px; background:linear-gradient(135deg, #E53935, #C62828); color:#fff; font-weight:900; font-size:13px;">
              ${b.bloodGroup}
            </span>
          </td>
          <td><strong>${b.unitsNeeded || 1} Units</strong></td>
          <td>
            <div><strong>${b.hospitalName || 'District Hospital'}</strong></div>
            <div style="font-size:11px; color:var(--muted-ink);">${b.district}</div>
          </td>
          <td>
            <a href="tel:${b.contactPhone}" style="color:var(--party-blue); text-decoration:none; font-weight:800; font-size:12.5px;">
              📞 ${b.contactPhone}
            </a>
          </td>
          <td>${statusBadge}</td>
          <td style="font-size:11.5px; font-weight:700; color:var(--party-blue);">${b.matchedDonor || 'Awaiting'}</td>
          <td>
            <div class="actions-cell">
              <button class="btn-icon-edit" onclick="openEditModal('blood-sos', '${b.id}')">✏️ Edit</button>
              <button class="btn-icon-del" onclick="deleteRecord('blood-sos', '${b.id}')">🗑️ Delete</button>
            </div>
          </td>
        </tr>
      `;
    }).join('');
  } catch (e) {
    console.error('Failed to load Blood SOS:', e);
  }
}

// ----------------------------------------------------
// 4. VOLUNTEERS
// ----------------------------------------------------
async function loadVolunteers() {
  try {
    const res = await fetch('/api/volunteers');
    store['volunteers'] = await res.json();
    const dist = document.getElementById('filter-vol-district').value;

    let list = store['volunteers'] || [];
    if (dist !== 'All') {
      list = list.filter(v => (v.district || '').toLowerCase() === dist.toLowerCase());
    }

    const tbody = document.querySelector('#table-volunteers tbody');
    if (list.length === 0) {
      tbody.innerHTML = `<tr><td colspan="9" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
        No volunteers enrolled yet in this district. Click "+ Enroll Volunteer" or register via mobile app.
      </td></tr>`;
      return;
    }

    tbody.innerHTML = list.map(v => `
      <tr>
        <td><strong>${v.id}</strong></td>
        <td><strong style="color:var(--ink);">${v.name}</strong></td>
        <td><a href="tel:${v.phone}" style="color:var(--party-blue); text-decoration:none; font-weight:800;">📞 ${v.phone}</a></td>
        <td><strong>${v.district}</strong></td>
        <td><span class="badge red">${v.bloodGroup || 'A+'}</span></td>
        <td><span class="badge blue">${v.wing || 'Congress Seva Dal'}</span></td>
        <td style="font-size:11.5px; color:var(--muted-ink);">${v.assignedTasks || 'Emergency Relief'}</td>
        <td><span class="badge green">${v.status || 'Active'}</span></td>
        <td>
          <div class="actions-cell">
            <button class="btn-icon-edit" onclick="openEditModal('volunteers', '${v.id}')">✏️ Edit</button>
            <button class="btn-icon-del" onclick="deleteRecord('volunteers', '${v.id}')">🗑️ Delete</button>
          </div>
        </td>
      </tr>
    `).join('');
  } catch (e) {
    console.error('Failed to load volunteers:', e);
  }
}

// ----------------------------------------------------
// 5. PETITIONS
// ----------------------------------------------------
async function loadPetitions() {
  try {
    const res = await fetch('/api/petitions');
    store['petitions'] = await res.json();
    const tbody = document.querySelector('#table-petitions tbody');

    if ((store['petitions'] || []).length === 0) {
      tbody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
        No youth petitions signed yet. Youth employment campaign is live in the mobile app.
      </td></tr>`;
      return;
    }

    tbody.innerHTML = store['petitions'].map(p => `
      <tr>
        <td><strong>${p.id}</strong></td>
        <td><strong style="color:var(--ink);">${p.name}</strong></td>
        <td><a href="tel:${p.phone}" style="color:var(--party-blue); text-decoration:none; font-weight:700;">📞 ${p.phone}</a></td>
        <td><strong>${p.district}</strong></td>
        <td><span class="badge blue">${p.qualification || 'Graduate'}</span></td>
        <td style="font-size:12px; max-width:260px;">${p.demand}</td>
        <td><span style="font-size:11px; color:var(--muted-ink);">${p.date || 'Today'}</span></td>
        <td>
          <div class="actions-cell">
            <button class="btn-icon-edit" onclick="openEditModal('petitions', '${p.id}')">✏️ Edit</button>
            <button class="btn-icon-del" onclick="deleteRecord('petitions', '${p.id}')">🗑️ Delete</button>
          </div>
        </td>
      </tr>
    `).join('');
  } catch (e) {
    console.error('Failed to load petitions:', e);
  }
}

// ----------------------------------------------------
// 6. SMART METERS
// ----------------------------------------------------
async function loadSmartMeters() {
  try {
    const res = await fetch('/api/smart-meters');
    store['smart-meters'] = await res.json();
    const tbody = document.querySelector('#table-meters tbody');

    if ((store['smart-meters'] || []).length === 0) {
      tbody.innerHTML = `<tr><td colspan="10" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
        No smart meter disputes filed yet. Awaiting consumer appeal submissions from mobile app.
      </td></tr>`;
      return;
    }

    tbody.innerHTML = store['smart-meters'].map(m => `
      <tr>
        <td><strong>${m.id}</strong></td>
        <td><strong style="color:var(--ink);">${m.consumerName}</strong></td>
        <td><code>${m.consumerNo}</code></td>
        <td><strong>${m.district}</strong></td>
        <td>${m.unitsBilled} Units</td>
        <td><strong style="color:var(--danger);">₹${m.amountCharged}</strong></td>
        <td><strong style="color:var(--green-deep);">₹${m.legitimateTariff}</strong></td>
        <td><span class="badge red">+₹${m.discrepancy} Overcharge</span></td>
        <td><span class="badge yellow">${m.status}</span></td>
        <td>
          <div class="actions-cell">
            <button class="btn-icon-edit" onclick="openEditModal('smart-meters', '${m.id}')">✏️ Edit</button>
            <button class="btn-icon-del" onclick="deleteRecord('smart-meters', '${m.id}')">🗑️ Delete</button>
          </div>
        </td>
      </tr>
    `).join('');
  } catch (e) {
    console.error('Failed to load smart meter disputes:', e);
  }
}

// ----------------------------------------------------
// 7. JAN SUNWAI
// ----------------------------------------------------
async function loadJanSunwai() {
  try {
    const res = await fetch('/api/jan-sunwai');
    store['jan-sunwai'] = await res.json();
    const tbody = document.querySelector('#table-jansunwai tbody');

    if ((store['jan-sunwai'] || []).length === 0) {
      tbody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
        No Jan Sunwai sessions scheduled yet. Click "+ Schedule Jan Sunwai" to publish one to all mobile app users.
      </td></tr>`;
      return;
    }

    tbody.innerHTML = store['jan-sunwai'].map(h => `
      <tr>
        <td><strong>${h.id}</strong></td>
        <td>
          <div style="font-weight:800; color:var(--ink);">${h.venue}</div>
          <div style="font-size:11px; color:var(--party-blue); font-weight:700;">${h.district}</div>
        </td>
        <td>
          <strong>${h.date}</strong>
          <div style="font-size:11px; color:var(--muted-ink);">${h.time || '11:00 AM – 3:00 PM'}</div>
        </td>
        <td style="font-size:12px; font-weight:700; color:var(--party-blue);">${h.leaders}</td>
        <td style="font-size:11.5px; color:var(--muted-ink);">${h.focusAreas}</td>
        <td><a href="tel:${h.coordinatorPhone}" style="color:var(--party-blue); text-decoration:none; font-weight:700;">📞 ${h.coordinatorPhone}</a></td>
        <td><span class="badge green">${h.slotsBooked || 0} Slots</span></td>
        <td>
          <div class="actions-cell">
            <button class="btn-icon-edit" onclick="openEditModal('jan-sunwai', '${h.id}')">✏️ Edit</button>
            <button class="btn-icon-del" onclick="deleteRecord('jan-sunwai', '${h.id}')">🗑️ Delete</button>
          </div>
        </td>
      </tr>
    `).join('');
  } catch (e) {
    console.error('Failed to load Jan Sunwai:', e);
  }
}

// ----------------------------------------------------
// 8. SNOW EMERGENCY
// ----------------------------------------------------
async function loadSnowSos() {
  try {
    const res = await fetch('/api/snow-sos');
    store['snow-sos'] = await res.json();
    const tbody = document.querySelector('#table-snow tbody');

    if ((store['snow-sos'] || []).length === 0) {
      tbody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
        No active snow emergency stretcher calls at this moment. Standby monitoring across high passes.
      </td></tr>`;
      return;
    }

    tbody.innerHTML = store['snow-sos'].map(s => {
      const isRescued = s.status === 'RESCUED';
      const badge = isRescued ? '<span class="badge green">RESCUED</span>' : '<span class="badge red">DISPATCHED</span>';

      return `
        <tr>
          <td><strong>${s.id}</strong></td>
          <td><strong style="color:var(--ink);">${s.patientName}</strong></td>
          <td><a href="tel:${s.attendantPhone}" style="color:var(--party-blue); text-decoration:none; font-weight:800;">📞 ${s.attendantPhone}</a></td>
          <td>
            <strong>${s.district}</strong>
            <div style="font-size:11px; color:var(--muted-ink);">${s.passArea}</div>
          </td>
          <td><span class="badge yellow">${s.distanceToRoad}</span></td>
          <td>${badge}</td>
          <td><div style="font-size:11.5px; font-weight:700; color:var(--party-blue);">${s.squadCaptain}</div></td>
          <td>
            <div class="actions-cell">
              <button class="btn-icon-edit" onclick="openEditModal('snow-sos', '${s.id}')">✏️ Edit</button>
              <button class="btn-icon-del" onclick="deleteRecord('snow-sos', '${s.id}')">🗑️ Delete</button>
            </div>
          </td>
        </tr>
      `;
    }).join('');
  } catch (e) {
    console.error('Failed to load Snow SOS:', e);
  }
}

// ----------------------------------------------------
// 9. FOREST RIGHTS (FRA)
// ----------------------------------------------------
async function loadForestRights() {
  try {
    const res = await fetch('/api/forest-rights');
    store['forest-rights'] = await res.json();
    const tbody = document.querySelector('#table-fra tbody');

    if ((store['forest-rights'] || []).length === 0) {
      tbody.innerHTML = `<tr><td colspan="7" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
        No tribal eviction stay cases pending. Legal aid desk ready.
      </td></tr>`;
      return;
    }

    tbody.innerHTML = store['forest-rights'].map(f => `
      <tr>
        <td><strong>${f.id}</strong></td>
        <td><strong style="color:var(--ink);">${f.claimant}</strong></td>
        <td><span class="badge blue">${f.clan}</span></td>
        <td>
          <strong>${f.district}</strong>
          <div style="font-size:11px; color:var(--muted-ink);">${f.forestRange}</div>
        </td>
        <td style="font-size:12px;">${f.kothaLocation}</td>
        <td><span class="badge green">${f.status}</span></td>
        <td>
          <div class="actions-cell">
            <button class="btn-icon-edit" onclick="openEditModal('forest-rights', '${f.id}')">✏️ Edit</button>
            <button class="btn-icon-del" onclick="deleteRecord('forest-rights', '${f.id}')">🗑️ Delete</button>
          </div>
        </td>
      </tr>
    `).join('');
  } catch (e) {
    console.error('Failed to load FRA:', e);
  }
}

// ----------------------------------------------------
// 10. SPORTS KITS
// ----------------------------------------------------
async function loadSportsKits() {
  try {
    const res = await fetch('/api/sports-kits');
    store['sports-kits'] = await res.json();
    const tbody = document.querySelector('#table-sports tbody');

    if ((store['sports-kits'] || []).length === 0) {
      tbody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
        No youth sports kit applications pending. Youth clubs can apply directly in the app.
      </td></tr>`;
      return;
    }

    tbody.innerHTML = store['sports-kits'].map(k => `
      <tr>
        <td><strong>${k.id}</strong></td>
        <td><strong style="color:var(--ink);">${k.clubName}</strong></td>
        <td>
          <div>${k.captainName}</div>
          <a href="tel:${k.captainPhone}" style="color:var(--party-blue); text-decoration:none; font-size:11.5px; font-weight:700;">📞 ${k.captainPhone}</a>
        </td>
        <td><strong>${k.panchayat}</strong></td>
        <td>${k.district}</td>
        <td><span class="badge saffron">${k.kitType}</span></td>
        <td><span class="badge green">${k.status}</span></td>
        <td>
          <div class="actions-cell">
            <button class="btn-icon-edit" onclick="openEditModal('sports-kits', '${k.id}')">✏️ Edit</button>
            <button class="btn-icon-del" onclick="deleteRecord('sports-kits', '${k.id}')">🗑️ Delete</button>
          </div>
        </td>
      </tr>
    `).join('');
  } catch (e) {
    console.error('Failed to load Sports Kits:', e);
  }
}

// ----------------------------------------------------
// 11. NOTICES
// ----------------------------------------------------
async function loadNotices() {
  try {
    const res = await fetch('/api/notices');
    store['notices'] = await res.json();
    const tbody = document.querySelector('#table-notices tbody');

    if ((store['notices'] || []).length === 0) {
      tbody.innerHTML = `<tr><td colspan="7" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
        No public notices broadcasted yet. Click "+ Broadcast New Circular" to publish.
      </td></tr>`;
      return;
    }

    tbody.innerHTML = store['notices'].map(n => {
      let prioClass = 'blue';
      if (n.priority === 'critical') prioClass = 'red';
      if (n.priority === 'high') prioClass = 'yellow';

      return `
        <tr>
          <td><strong>${n.id}</strong></td>
          <td><strong style="color:var(--ink);">${n.title}</strong></td>
          <td><span class="badge ${prioClass}">${(n.priority || 'normal').toUpperCase()}</span></td>
          <td style="font-size:11.5px; font-weight:700; color:var(--party-blue);">${n.authorName || 'RGPRS HQ'}</td>
          <td style="font-size:11px; color:var(--muted-ink);">${(n.createdAt || '').split('T')[0]}</td>
          <td style="font-size:12px; max-width:280px;">${n.body}</td>
          <td>
            <div class="actions-cell">
              <button class="btn-icon-edit" onclick="openEditModal('notices', '${n.id}')">✏️ Edit</button>
              <button class="btn-icon-del" onclick="deleteRecord('notices', '${n.id}')">🗑️ Delete</button>
            </div>
          </td>
        </tr>
      `;
    }).join('');
  } catch (e) {
    console.error('Failed to load notices:', e);
  }
}

// ----------------------------------------------------
// 12. DIGITAL MEMBERSHIPS & PRI
// ----------------------------------------------------
async function loadMembers() {
  try {
    const res = await fetch('/api/members');
    store['members'] = await res.json();
    filterMembers();
  } catch (e) {
    console.error('Failed to load members:', e);
  }
}

function filterMembers() {
  const dist = document.getElementById('filter-mem-district').value;
  const role = document.getElementById('filter-mem-role').value;
  const stat = document.getElementById('filter-mem-status').value;

  let list = store['members'] || [];
  if (dist !== 'All') {
    list = list.filter(m => (m.district || '').toLowerCase() === dist.toLowerCase());
  }
  if (role !== 'All') {
    list = list.filter(m => (m.role || '').toLowerCase() === role.toLowerCase());
  }
  if (stat !== 'All') {
    list = list.filter(m => (m.status || '').toLowerCase() === stat.toLowerCase());
  }

  const tbody = document.querySelector('#table-members tbody');
  if (list.length === 0) {
    tbody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding: 28px; color: var(--muted-ink); font-weight:700;">
      No members or elected PRI representatives found under selected filters.
    </td></tr>`;
    return;
  }

  tbody.innerHTML = list.map(m => {
    const isPri = ['sarpanch', 'panch', 'bdc', 'ddc'].includes((m.role || '').toLowerCase());
    const roleBadge = isPri
      ? `<span class="badge saffron">${(m.role || '').toUpperCase()} (PRI)</span>`
      : `<span class="badge blue">Digital Member</span>`;

    const statusBadge = m.status === 'verified'
      ? `<span class="badge green">VERIFIED</span>`
      : `<span class="badge yellow">PENDING DRO</span>`;

    return `
      <tr>
        <td><code>${m.memberCode}</code></td>
        <td>
          <div style="font-weight:800; color:var(--ink);">${m.name}</div>
          <a href="tel:${m.phone}" style="color:var(--party-blue); text-decoration:none; font-size:11.5px; font-weight:700;">📞 ${m.phone}</a>
        </td>
        <td>
          <strong>${m.district}</strong>
          ${m.tehsil ? `<div style="font-size:11px; color:var(--muted-ink);">${m.tehsil}</div>` : ''}
        </td>
        <td>${roleBadge}</td>
        <td style="font-size:11.5px; color:var(--muted-ink);">${m.gazetteProof || 'Digital Sign-up'}</td>
        <td>${statusBadge}</td>
        <td>
          <div class="actions-cell">
            <button class="btn-icon-edit" onclick="openEditModal('members', '${m.id || m.memberCode}')">✏️ Edit</button>
            <button class="btn-icon-del" onclick="deleteRecord('members', '${m.id || m.memberCode}')">🗑️ Delete</button>
          </div>
        </td>
      </tr>
    `;
  }).join('');
}

// ----------------------------------------------------
// VOICE & PHOTO MODALS
// ----------------------------------------------------
function playVoiceAudio(id, snippet, encodedAudio) {
  const decodedSnippet = decodeURIComponent(snippet || 'Attached Voice Statement');
  const audioData = encodedAudio ? decodeURIComponent(encodedAudio) : '';
  
  document.getElementById('audio-modal-snippet').innerText = `Grievance: ${id} — ${decodedSnippet}`;
  const player = document.getElementById('audio-player-element');
  
  if (player) {
    if (audioData && audioData.startsWith('data:audio')) {
      player.src = audioData;
      player.load();
      player.play().catch(e => console.log('Audio autoplay prevented or error:', e));
    } else {
      player.removeAttribute('src');
      player.load();
    }
  }
  
  document.getElementById('modal-audio').classList.add('active');
}

function closeAudioModal() {
  const audio = document.getElementById('audio-player-element');
  if (audio) {
    audio.pause();
    audio.removeAttribute('src');
  }
  document.getElementById('modal-audio').classList.remove('active');
}

function viewPhotoEvidence(id, title, encodedPhoto) {
  const decodedTitle = decodeURIComponent(title || 'Evidence Photo');
  const photoData = encodedPhoto ? decodeURIComponent(encodedPhoto) : '';
  
  document.getElementById('photo-modal-caption').innerText = `Complaint ${id}: ${decodedTitle}`;
  const img = document.getElementById('photo-viewer-img');
  
  if (photoData && photoData.startsWith('data:image')) {
    img.src = photoData;
  } else {
    img.src = '/logos/inc_logo.png';
  }
  
  document.getElementById('modal-photo').classList.add('active');
}

function closePhotoModal() {
  document.getElementById('modal-photo').classList.remove('active');
}

// CSV Export Trigger
function exportData(type) {
  window.location.href = `/api/export/${type}`;
}

// Initial Boot & Auto-refresh Polling (every 4 seconds)
loadOverview();
setInterval(() => {
  const activeTab = document.querySelector('.nav-item.active');
  const tabId = activeTab ? activeTab.getAttribute('data-tab') : 'tab-overview';
  if (tabId === 'tab-overview') {
    loadOverview();
  }
}, 4000);
