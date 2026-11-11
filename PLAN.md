# RGPRS J&K — App Plan

**Working title:** *RGPRS J&K Sangathan* · **Working package id:** `org.inc.rgprs.jk`
**Stack decided by workspace:** Flutter (Dart 3.13.2 available locally), Android-first.
**Status:** plan for sign-off, nothing built yet.

---

## 1. What this app is

The **Rajiv Gandhi Panchayati Raj Sangathan (RGPRS)** is the Indian National Congress's
organizational wing for the panchayati raj system — it is where the party's grassroots
elected representatives and cadre live. A J&K chapter therefore has one job:

> **One app for J&K's PRI elected representatives (panches, sarpanches, BDC, DDC chairpersons
> and members) and the RGPRS unit that organises them — offline-first, multilingual, and
> safe for people who carry their phones in Kashmir.**

Three pillars, in priority order:

| Pillar | Why it earns the app |
|---|---|
| **Sangathan** — org tree, cadre directory, verification, unit communication | The party's actual pain: who is in which halqa panchayat, who leads, who isn't answering |
| **Sanchay** — panchayat governance record: funds, works, gram sabha, resolutions | Makes it a *governance tool*, not a CRM; gives reps something they actually want to open |
| **Sampark** — citizen grievance intake + scheme navigator routed to the local rep | Puts the party in the flow of citizens' daily problems; generates proof of work |

---

## 2. Context and assumptions (verify before building)

**J&K panchayati raj structure** *(counts are approximate — reconcile against the Dept. of
Rural Development & Panchayati Raj, J&K and the CEO's notifications before seeding data):*

- **3 tiers:** Halqa Panchayat → **Block Development Council (BDC)** → **District Development Council (DDC)**
- **20 districts**, 2 divisions (Jammu, Kashmir)
- ≈ **285 BDCs**, **280 DDC seats** (14 constituencies per district)
- ≈ **4,300 halqa panchayats** and ≈ 30,000+ panch seats
- Seats are **reserved on rotation** — for women (J&K reserves 50%), SC and ST
- Governing law: **J&K Panchayati Raj Act, 1989** (amended), plus the 73rd Amendment framework
- Urban Local Bodies (Srinagar/Jammu corporations, councils, committees) are a **separate wing**
  — out of scope for v1 unless told otherwise.

**Assumptions to confirm (Section 14 has the full list):** this is an official state-unit app,
not a district pilot; there is no pre-existing membership database (or there is — tell me);
booth/voter roll data is deliberately excluded; hosting must be in India.

---

## 3. Users

1. **Panch / Sarpanch** — 45–65, low digital literacy, mid/low Android, shared phone, Urdu-first.
2. **BDC / DDC member** — runs a block or district unit; needs reporting, attendance, task tracking.
3. **RGPRS block/district/state office bearer** — verifies members, broadcasts, assigns tasks, reads dashboards.
4. **Congress worker (non-panchayat)** — grassroots volunteer; directory + mobilization + content to share.
5. **Citizen (login-light)** — submits a grievance, checks scheme eligibility, reads the works ledger.
6. **State admin (web)** — the person running all of it; needs bulk management, audit trail, exports for AICC.

---

## 4. Scope by release

### v1 — MVP (≈ 10 weeks of build)
1. **Phone-OTP sign-in** (Hindi/Urdu/English guided onboarding).
2. **Org tree browser**: State → Division → District → Block → Halqa → Ward, built from a canonical geo master.
3. **Membership + digital ID**: onboarding form → block-level verifier approval → digital membership
   card with QR (works fully offline for ID checks).
4. **Member directory with privacy tiers** (see §8) — phone numbers masked by default, contact
   requests require an in-app reason.
5. **Representative register**: tier (panch/sarpanch/BDC/DDC), seat, constituency, term dates.
   Seat-level reservation is recorded on the *seat*, never on the person.
6. **Notice feed** (state → block → halqa scoped), in-app inbox + push, read receipts at unit level.
7. **Admin web console**: verification queue, org master data, role assignment, audit log.
8. **Offline core**: full read of own unit, queue writes while offline, reconcile on reconnect.

### v2 (next ~8 weeks)
9. **Grievance intake** with photo + voice note + category → routed to halqa rep → SLA clock →
   escalation to block after N days → district after M days; citizen tracks by reference ID.
10. **Sanchay ledger**: scheme-wise works (15th FC grants, MGNREGA, PMAY-G, Jal Jeevan Mission,
    ISSS pension, Laadli Beti etc.) with sanctioned/spent amounts, geo-tagged before/after photos,
    and a **public works view** (aggregated at panchayat level, no beneficiary names published).
11. **Gram Sabha register digitized**: meeting date, agenda, attendance, minutes, resolutions +
    action-taken status.
12. **Training & capacity building**: role-based courses (Sarpanch 101, DDC 101, MGNREGA 101 …),
    audio-narrated low-bandwidth video, offline download packs, quiz → RGPRS certificate,
    completion report by unit.

### v3
13. **Surveys & field data collection** — admin builds a form, targets a halqa/block, workers fill
    offline; results dashboard by district.
14. **Mobilization**: event RSVP + QR check-in, cascading task assignment with photo proof.
15. **Shareable content studio** — centrally published cards/audio/video in Urdu/Hindi for WhatsApp
    sharing, share counts (never *who* shared).
16. **Scheme navigator for citizens** ("Mera Adhikar"): eligibility quiz, document checklist, link-outs.

### Explicit non-goals (legal review gate on each)
- ❌ **Voter/electoral roll data or booth-level voter management** — do not store EPIC/voter data. Election management with voter lists is a different product with a different legal posture; mixing it in turns every grievance into a compliance problem.
- ❌ **Donations / in-app payments in v1** — FCRA + RPA §29B reporting; needs party legal sign-off first.
- ❌ **Caste, religion, or Aadhaar data.** Aadhaar is not for private/NGO-style KYC; EPIC only as
  a hashed last-4, if at all.
- ❌ **No third-party analytics/ad SDKs** (Meta, Google Analytics, Mixpanel etc.) — they would export
  member PII offshore, defeating the data-residency goal.
- ❌ No in-app SMS blast as a default channel (cost + DLT burden); in-app inbox is primary.

---

## 5. J&K-specific requirements (these are not nice-to-haves)

| Requirement | Consequence |
|---|---|
| **Offline-first** | Recurring mobile-internet shutdowns and 2G in far-flung blocks: the app must be **fully usable for 7 days offline** (read everything in your unit, queue everything you write). |
| **Urdu is first-class** | RTL layout from day one; Urdu is the first official language. Hindi/English shipped together; **Dogri, Kashmiri, Punjabi** in v2. Nastaliq + Devanagari fonts (subset/compress — they're heavy). |
| **Low-end Android** | Target Android 7+ (minSdk 24), 2–3 GB RAM devices common; app size budget **≤ 25 MB** core + on-demand language packs; no background service churn; compress images client-side before upload. |
| **Shared phones** | Do not bind the account to a device; support fast account switching on the same handset. |
| **Cadre safety** | See §8. Assume device seizure is possible: encrypt local storage, no plaintext bulk exports on device, remote session revoke, auto-logout, minimal local retention of contact data. |
| **Voice for low literacy** | Course narration, voice-note grievances, voice-first help; text is never the only path. |

---

## 6. Technical architecture

### Client (Flutter)
- **State:** Riverpod · **Routing:** go_router · **Local DB:** Drift (SQLite) with SQLCipher encryption ·
  **HTTP:** dio with retry/backoff · **Images:** flutter_image_compress + cached_network_image.
- **Sync = outbox pattern:** every write lands in a local outbox with a client UUID idempotency key;
  a background worker drains it with exponential backoff; reads pull by cursor
  (`revision > last_seen`). Conflict policy: server timestamp last-write-wins per *field* (not whole
  row), so two edits to different fields of the same grievance don't clobber each other.
- Sync defaults to Wi-Fi-friendly, foreground-triggered first, opportunistic in background.

### Backend (needs a procurement decision)
Two viable shapes; **the Gravity Index catalog returned no matching provider for either need, so
nothing is recommended here — this is a decision the party's IT team must sign off on, with
pricing and DLT/residency terms verified before purchase.**

| Option | Shape | Trade-off |
|---|---|---|
| **A. Modular monolith (recommended for v1)** | Fastify/Hono or Go + Postgres + S3-compatible storage (MinIO) + Redis for queues/rate limits, deployed to an **Indian region** (AWS `ap-south-1` Mumbai or an Indian provider) | Full control over residency + RLS + audit, plain SQL, no vendor lock-in; you own patching/backups |
| **B. Self-hosted BaaS** | Supabase self-hosted (Postgres + RLS + storage) or PocketBase (single Go binary + SQLite) on an Indian VPS | Fastest to build, cheapest to run; BaaS upgrade path must be planned for before ~100k rows |

Either way: **data residency in India at rest**, encrypted at rest and in transit, row-level
authorization on every table, and **no member-data export without an audit-log entry**.

**Auth:** phone OTP via an Indian SMS provider that handles **TRAI DLT registration**
(MSG91, Gupshup, Kaleyra, 2Factor, Fast2SMS — verify current DLT/registration terms).
Rate-limit per phone + per device; OTP is the only factor in v1 (no passwords).

**Push:** FCM for Android (free, Google dependency) + the in-app inbox as the source of truth.
Critical-only SMS fallback.

**Admin console:** a separate web app (same backend), desktop-first, scoped by role.

### Why offline-first is load-bearing
Every module (grievance, survey, task, works entry, notice read) must degrade to "queue and
reconcile". If a feature can't survive a 7-day connectivity gap, it isn't ready for v1.

---

## 7. Data model (sketch)

```
org_units(id, type[state|division|district|block|halqa|ward], name_en, name_ur,
          parent_id, geo_code, centroid)
seats(id, org_unit_id, tier[panch|sarpanch|bdc|ddc], number,
      reservation[women|sc|st|general], electorate_size)      -- reservation on the SEAT, not the person
users(id, phone_hash, phone_enc, name, preferred_lang, status, created_at)
memberships(user_id, org_unit_id, role, status[pending|verified|suspended],
            verified_by, verified_at, term_start, term_end)
representatives(user_id, seat_id, tier, party_status, term_start, term_end)
grievances(id, ref_code, citizen_phone_hash, halqa_id, category, description,
           media_ids[], status, assigned_to, sla_due_at, escalation_level,
           resolution_note, resolved_at)
grievance_events(grievance_id, actor_id, event_type, note, created_at)
works(id, org_unit_id, scheme, title, sanctioned_amount, spent_amount, status,
      started_on, completed_on, evidence_media_ids[], source_reference)
gram_sabha_meetings(halqa_id, date, agenda, attendance_count, minutes_media_id)
resolutions(meeting_id, text, status, action_taken, resolved_at)
notices(id, audience_rule, title, body_lang_map, priority, published_at, push_sent_at)
notice_receipts(notice_id, user_id, read_at)
courses(id, title, audience_role, lang, media_ids[], duration_min, version)
enrollments(user_id, course_id, progress, completed_at, certificate_id)
events(id, org_unit_id, title, type, starts_at, location, target_count)
event_attendance(event_id, user_id, checked_in_at, method)
tasks(id, org_unit_id, title, due_at, assigned_by, status, proof_media_ids[])
task_assignments(task_id, user_id, status, completed_at)
surveys(id, title, target_rule, form_schema, opens_at, closes_at, status)
survey_responses(survey_id, user_id, halqa_id, answers, captured_at, synced_at)
content_cards(id, lang, title, media_id, share_count, tags[])
outbox(client_uuid, entity, op, payload, attempts, last_error, created_at)
sync_cursors(user_id, device_id, last_revision)
audit_log(actor_id, action, entity, entity_id, change, ip, created_at)      -- every admin action
data_access_log(admin_id, entity, filter, row_count, purpose, created_at)   -- every bulk read
```

Design note: `seat.reservation` (a public fact about a constituency) is modelled instead of
`person.caste` (sensitive personal data) — this is the privacy-by-design decision that keeps
women's-reservation reporting possible without collecting caste.

---

## 8. Roles and privacy tiers

| Capability | Worker (unverified) | Verified member | Office bearer | State admin |
|---|---|---|---|---|
| Read own-unit notices | ✅ | ✅ | ✅ | ✅ |
| Read member directory (own block) | — | ✅ masked | ✅ full by unit | ✅ full |
| Read member directory (other district) | — | — | ✅ masked + reason | ✅ full |
| Submit grievance / task proof / survey | ✅ | ✅ | ✅ | ✅ |
| Verify members of own unit | — | — | ✅ | ✅ |
| Broadcast (scoped to own subtree) | — | — | ✅ | ✅ |
| Bulk export member data | — | — | — | ❌ (audited request flow only) |
| Org master data / roles / audit log | — | — | — | ✅ |

**Default: mask every phone number.** Unmasking requires a logged reason; each unmask writes a
`data_access_log` row. There is **no API path that returns a full member list in plaintext.**

---

## 9. Compliance & security

- **DPDP Act 2023:** consent notice in Hindi/Urdu/English at onboarding, purpose-bounded fields
  (no optional fields in v1), data-deletion request flow, data-minimization inventory.
  Run a short **DPIA** before Phase 1 closes — it's cheap now and expensive later.
- **Data residency:** at-rest storage in India; documented in the consent notice.
- **No electoral roll / EPIC storage** (see non-goals).
- **Device security:** SQLCipher local DB, app lock (biometric + PIN), auto-lock after 5 min,
  remote session revoke from the admin console, screenshot redaction on directory screens where
  feasible, encrypted local cache of uploads.
- **Backend:** row-level authorization, rate limits on OTP and directory reads, signed upload URLs
  (no public object paths), full audit of admin actions and bulk reads, secrets via a secrets manager.
- **Play policy:** declare political/org content to Google Play; plan a **direct APK mirror** for
  devices without Play.
- **Penetration test** before state-wide rollout; third-party dependency scan in CI.

---

## 10. Rollout plan

| Phase | Weeks | Deliverables | Exit criteria |
|---|---|---|---|
| **0 — Discovery** | 1–2 | Reconcile org tree + seats with official notifications; legal/DPIA kickoff; pick backend + SMS provider; scope sign-off | Geo master vetted by state unit; procurement quotes in hand |
| **1 — MVP** | 3–10 | Auth, org tree, membership + verification, directory w/ privacy tiers, representative register, notice feed, admin console, offline core | 200 seeded members verified offline; a full day of use with airplane mode |
| **2 — Sanchay + Sampark** | 11–18 | Grievances + SLA, works ledger, gram sabha register, training v1 (3 languages, offline packs) | 50 real grievances routed end-to-end; 200 training completions |
| **3 — Mobilization** | 19–24 | Surveys, tasks, events, share studio, dashboards | 2 district pilots, one per division |
| **4 — Hardening** | 25–28 | Pen test, performance/size budget, accessibility, content freeze | Pen test findings closed; ≤25 MB install; 99% crash-free sessions |
| **5 — State rollout** | 29+ | Staged by division, field onboarding squads, training of trainers | Verified-member activation target set with state unit |

**Pilot gate:** do not go state-wide after Phase 2. Pilot in **two districts — one Jammu division,
one Kashmir division** — for 4 weeks, then decide.

**Seasonal note:** aim to have Phase 2 live before the next panchayat poll cycle if one is
scheduled; campaign-readiness is the forcing function for adoption.

---

## 11. Team & budget (indicative — verify current rates)

| Role | Count | Months |
|---|---|---|
| Product/PM + party liaison | 1 | 6 |
| Flutter engineers | 2 | 6 |
| Backend engineer | 1 | 6 |
| Designer | 1 | 4 |
| QA + DevOps (part-time) | 1 | 6 |
| Security consultant | 1 (audit, ~3 wks) | — |
| Content lead + Urdu translator + voice artist | 1 + 2 | 4 |
| Field ops coordinator per division | 2 | 4 |

- **Build (lean in-house/small agency, ~6 months): ≈ ₹45–65 lakh**
- **Year-1 infra:** ≈ ₹8–20k/month (small instances + storage) + OTP/SMS and image storage scales
  with usage; **≈ ₹1.5–4 lakh/year**
- **Content production:** ≈ ₹3–8 lakh · **Security audit:** ≈ ₹3–6 lakh · **Pilot/field logistics:** ≈ ₹2–4 lakh
- **Year-1 total (lean): ≈ ₹55–85 lakh.** Agency/full-scope path: ≈ ₹1.2–1.8 crore.

*All figures are planning estimates only; verify against actual vendor quotes and party payroll.*
*Funding note: political parties cannot accept foreign contributions (FCRA), and domestic donations
carry reporting obligations — get legal sign-off before any payment feature or funding arrangement.*

---

## 12. Risks

| Risk | Sev | Mitigation |
|---|---|---|
| **Cadre PII leak / misuse** — masked directory, no exports, audit on every bulk read, no third-party SDKs, encrypted local store | 🔴 High | |
| Device seizure or search | 🔴 High | Minimal local retention, remote revoke, auto-lock, no plaintext lists on device |
| Low adoption by older sarpanches | 🟠 High | Field onboarding squads, assisted onboarding, voice-first, Urdu-first, QR membership card as the daily "why" |
| Connectivity shutdowns | 🟠 High | 7-day offline budget, sync-on-reconnect, SMS only for critical notices |
| Verification bottleneck (thousands of members) | 🟠 Med | Block-level verifiers + tiered trust (pending/verified/office-bearer) |
| Scope creep into voter/booth data | 🔴 High | Written non-goals; legal gate on any change |
| Backend/SMS vendor terms (DLT, residency, price) | 🟠 Med | Procurement in Phase 0; no provider chosen yet |
| Play Store political-content rejection | 🟡 Med | Disclose org status; keep direct APK path ready |
| Device sharing / account confusion | 🟡 Med | Fast account switcher, no device binding |

---

## 13. Success metrics

- **Activation:** % of invited members verified within 14 days
- **Liveness:** weekly active *units* (a halqa that opened the app) — not vanity downloads
- **Grievances:** median time to first response; % closed inside SLA
- **Transparency:** works records published per panchayat per month
- **Training:** completion % by district; certificate issuance for AICC reporting
- **Survey coverage:** halqa response rate for each survey
- **Quality:** ≥99% crash-free sessions, sync success ≥99.5% on first retry, install ≤25 MB

---

## 14. Open decisions (need your answer)

1. **Scope:** state-wide RGPRS J&K app, or start with one district pilot?
2. **Seed data:** is there an existing membership/representative list to import, or does v1 start empty?
3. **Booth/voter data:** confirm it's out of scope (recommend: yes, out of scope).
4. **Hosting/vendor:** existing party IT standard or AICC system to conform to? India-only hosting confirmed?
5. **Deadline:** is there an upcoming panchayat election or AICC deadline driving the date?
6. **iOS:** needed now, or Android-only for v1?
7. **Donations:** ever in scope, or permanently out?
8. **Languages:** is Dogri/Kashmiri needed in v1 for a specific district?

---

## 15. Appendix — proposed repo layout

```
rgprs_jk/
  app/
    lib/
      core/        # theme, l10n (en/hi/ur), router, di, errors
      data/        # drift schema, outbox, sync engine, api client, repositories
      features/
        auth/  org/  membership/  directory/  representative/
        notices/  grievance/  works/  gramsabha/  training/
        survey/  mobilization/  content/  profile/
      shared/      # widgets: voice recorder, offline badge, lang switcher
    test/  integration_test/
  admin_web/       # admin console (separate app, same backend)
  backend/         # API, migrations, worker (outbox/jobs), seed scripts
  content/         # course + share-card source files, per language
  docs/            # this plan, DPIA, org master data spec, API contract
```

**Next engineering step:** `flutter create` this workspace (template already set to `app`),
then Phase 0 tasks.
