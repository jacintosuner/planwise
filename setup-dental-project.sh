#!/bin/bash

# Create root level directories
mkdir -p backend/app/{api/v1/endpoints,core,db,models,schemas}
mkdir -p backend/tests
mkdir -p backend/alembic

# Create frontend structure
npx create-react-app frontend --template typescript

# Install frontend dependencies
cd frontend
npm install @emotion/react @emotion/styled @mui/material @mui/icons-material \
    @mui/x-date-pickers @reduxjs/toolkit axios date-fns react-hook-form \
    react-query react-redux react-router-dom

# Install frontend dev dependencies
npm install --save-dev @testing-library/jest-dom @testing-library/react \
    @typescript-eslint/eslint-plugin @typescript-eslint/parser \
    eslint eslint-plugin-react prettier

# Create frontend directory structure
cd src
mkdir -p components/{common,patients,appointments} hooks services store/{slices} types utils
cd ../..  # Return to root

# Create backend files
touch backend/app/__init__.py
touch backend/app/main.py

# API endpoints
touch backend/app/api/__init__.py
touch backend/app/api/v1/__init__.py
touch backend/app/api/v1/api.py
touch backend/app/api/v1/endpoints/{__init__.py,patients.py,appointments.py,users.py}

# Core functionality
touch backend/app/core/{__init__.py,config.py,security.py}

# Database
touch backend/app/db/{__init__.py,base.py,session.py}

# Models and schemas
touch backend/app/models/{__init__.py,patient.py,appointment.py,user.py}
touch backend/app/schemas/{__init__.py,patient.py,appointment.py,user.py}

# Tests
touch backend/tests/{__init__.py,conftest.py,test_patients.py,test_appointments.py}

# Create frontend files (adjust path)
cd frontend/src
touch components/common/{Layout.tsx,Navbar.tsx,LoadingSpinner.tsx,ErrorBoundary.tsx}
touch components/patients/{PatientList.tsx,PatientForm.tsx,PatientDetail.tsx}
touch components/appointments/{AppointmentList.tsx,AppointmentForm.tsx}
touch hooks/{useAuth.ts,usePatients.ts}
touch services/{api.ts,auth.ts}
touch store/slices/{authSlice.ts,patientSlice.ts}
touch store/store.ts
touch types/{patient.ts,appointment.ts,user.ts}
touch utils/{axios.ts,dateUtils.ts}
touch routes.tsx
cd ..

# Create environment files (adjust paths)
echo "REACT_APP_API_URL=http://localhost:8000/api/v1
REACT_APP_ENV=development" > frontend/.env

# Create backend environment file
echo "PROJECT_NAME=Planwise
BACKEND_CORS_ORIGINS=[\"http://localhost:3000\"]
SECRET_KEY=your-secret-key-here
FIRST_SUPERUSER=admin@example.com
FIRST_SUPERUSER_PASSWORD=admin
POSTGRES_SERVER=localhost
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=planwise
SQLALCHEMY_DATABASE_URI=postgresql://postgres:postgres@localhost/planwise" > backend/.env

# Create requirements.txt in backend directory
echo "fastapi>=0.104.0
uvicorn>=0.24.0
sqlalchemy>=2.0.23
pydantic>=2.4.2
pydantic-settings>=2.0.3
alembic>=1.12.1
python-jose>=3.3.0
passlib>=1.7.4
python-multipart>=0.0.6
emails>=0.6
jinja2>=3.1.2
python-dotenv>=1.0.0
psycopg2-binary>=2.9.9
pytest>=7.4.3
httpx>=0.25.1
pytest-asyncio>=0.21.1
asgi-lifespan>=2.1.0" > backend/requirements.txt

# Create Python virtual environment and install dependencies
cd backend
python -m venv env
source env/bin/activate  # On Windows use: .\env\Scripts\activate
pip install -r requirements.txt

# Initialize alembic
alembic init alembic

# Create initial FastAPI app
echo "from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.api.v1.api import api_router

app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f\"{settings.API_V1_STR}/openapi.json\"
)

# Set all CORS enabled origins
if settings.BACKEND_CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
        allow_credentials=True,
        allow_methods=[\"*\"],
        allow_headers=[\"*\"],
    )

app.include_router(api_router, prefix=settings.API_V1_STR)" > app/main.py
cd ..

# Initialize git repository
git init

# Create root level .gitignore
echo "# Backend
__pycache__/
*.py[cod]
*\$py.class
*.so
.Python
env/
venv/
.env
.venv
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
*.egg-info/
.installed.cfg
*.egg
*.db

# Frontend
node_modules/
/build
.DS_Store
.env.local
.env.development.local
.env.test.local
.env.production.local
npm-debug.log*
yarn-debug.log*
yarn-error.log*
coverage/

# IDEs
.idea/
.vscode/
*.swp
*.swo

# Local development
docker-compose.override.yml" > .gitignore

# Create root level README.md
echo "# Planwise

A modern dental practice management system built with FastAPI and React (TypeScript).

## Prerequisites

- Python 3.8+
- Node.js 18+
- PostgreSQL 13+

## Getting Started

### Backend Setup

1. Create virtual environment:
\`\`\`bash
cd backend
python -m venv env
source env/bin/activate  # On Windows use: .\\env\\Scripts\\activate
\`\`\`

2. Install dependencies:
\`\`\`bash
pip install -r requirements.txt
\`\`\`

3. Set up environment variables:
\`\`\`bash
cp .env.example .env
# Edit .env with your configuration
\`\`\`

4. Run migrations:
\`\`\`bash
alembic upgrade head
\`\`\`

5. Start the server:
\`\`\`bash
uvicorn app.main:app --reload
\`\`\`

### Frontend Setup

1. Install dependencies:
\`\`\`bash
cd frontend
npm install
\`\`\`

2. Start the development server:
\`\`\`bash
npm start
\`\`\`

## API Documentation

Visit http://localhost:8000/docs for the interactive API documentation." > README.md

echo "Project structure created successfully!"