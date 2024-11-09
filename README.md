# Planwise

A modern dental practice management system built with FastAPI and React (TypeScript).

## Prerequisites

- Python 3.8+
- Node.js 18+
- PostgreSQL 13+

## Getting Started

### Backend Setup

1. Create virtual environment:
```bash
cd backend
python -m venv env
source env/bin/activate  # On Windows use: .\env\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Run migrations:
```bash
alembic upgrade head
```

5. Start the server:
```bash
uvicorn app.main:app --reload
```

### Frontend Setup

1. Install dependencies:
```bash
cd frontend
npm install
```

2. Start the development server:
```bash
npm start
```

## API Documentation

Visit http://localhost:8000/docs for the interactive API documentation.
