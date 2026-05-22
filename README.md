# My App — Course API Integration

## Branch Name
`feature/course-api-integration`

---

## API Used
**JSONPlaceholder** — Free fake REST API for testing and prototyping.

Base URL used: `https://jsonplaceholder.typicode.com/posts`

---

## Documentation Reference
- Official guide followed: https://jsonplaceholder.typicode.com/guide
- Endpoints used:
  - `GET /posts` — Fetch all courses
  - `POST /posts` — Create a new course
  - `PUT /posts/:id` — Update an existing course
  - `DELETE /posts/:id` — Delete a course

---

## Features Implemented

- **Read** — Fetches course list from API on dashboard load with a loading indicator and error handling
- **Create** — Add a new course via dialog; UI updates after successful POST response
- **Update** — Edit existing course with pre-filled form; sends PUT request and reflects changes in UI
- **Delete** — Delete a course with confirmation dialog; removes item after successful DELETE response

---

## Screenshots

<img width="1911" height="877" alt="{1DAF6A2B-F415-4FBC-8BA2-098B84415CAA}" src="https://github.com/user-attachments/assets/a36eeeaf-2f22-4098-be53-6608d4e73814" />
<img width="1911" height="486" alt="{7591CD18-0626-4A9E-BAB4-546DCD83D752}" src="https://github.com/user-attachments/assets/1c0a0852-505d-4037-95dd-6b9096b8bf58" />
<img width="1903" height="578" alt="{CEF73583-3DEA-493C-8AD0-39B1B36C26A5}" src="https://github.com/user-attachments/assets/cede451e-fac3-40f8-9cb1-ce7e279fa476" />
<img width="1913" height="734" alt="{0ABAFCAD-E15C-4138-A947-0D30C63A57CF}" src="https://github.com/user-attachments/assets/5a364698-69b0-47eb-952d-944456d6298e" />

---

## Architecture

- `lib/services/api_service.dart` — All API calls isolated in a dedicated service layer
- `lib/controllers/subject_controller.dart` — State management via `ChangeNotifier`
- `lib/models/subject.dart` — Data model with `fromJson` / `toJson`
- `lib/screens/` — UI only; no API logic in widgets
