# 🚀 Quick Start Guide

## For Beginners: 5-Minute Setup

### Step 1: Install Prerequisites (One-Time)

**Install Node.js:**
- Download from: https://nodejs.org/ (v16 or higher)
- Verify: Open terminal and run `node -v`

**Install Python:**
- Download from: https://www.python.org/ (v3.8 or higher)
- Verify: Run `python3 --version`

**MongoDB Options:**

**Option A: Local MongoDB** (Recommended for Development)
- Download: https://www.mongodb.com/try/download/community
- Install and start MongoDB service

**Option B: MongoDB Atlas** (Cloud - Easier for Beginners)
- Go to: https://www.mongodb.com/cloud/atlas
- Create free account
- Create a cluster (free tier available)
- Get connection string (looks like: mongodb+srv://...)

### Step 2: Download and Setup

```bash
# Clone or download this project
cd smartrecruit

# Run automatic setup (installs all dependencies)
chmod +x setup.sh
./setup.sh

# Or manual installation:
# cd backend && npm install
# cd ../ai-engine && pip install -r requirements.txt
# cd ../frontend && npm install
```

### Step 3: Configure Environment

**Edit `backend/.env`:**
```env
# MongoDB Connection
MONGODB_URI=mongodb://localhost:27017/smartrecruit
# OR use MongoDB Atlas:
# MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/smartrecruit

# JWT Secret (change this!)
JWT_SECRET=my_super_secret_key_12345

# Email (Gmail)
EMAIL_USER=your-email@gmail.com
EMAIL_PASS=your-gmail-app-password
```

**How to get Gmail App Password:**
1. Go to your Google Account
2. Security → 2-Step Verification (enable it)
3. Security → App passwords
4. Generate password for "Mail"
5. Copy and paste in .env

### Step 4: Start the Application

**Terminal 1 - Backend:**
```bash
cd backend
npm start
```
You should see: "MongoDB Connected" and "Server Running on port 5000"

**Terminal 2 - Frontend:**
```bash
cd frontend
npm start
```
Browser will open automatically at http://localhost:3000

### Step 5: Test the System

**Register as Candidate:**
1. Click "Register here"
2. Fill form (select role: Candidate)
3. Login
4. Upload a resume (PDF or TXT)
5. See your resume info

**Register as HR:**
1. Logout (or open incognito window)
2. Register with role: HR
3. Login
4. Click "Create New Job"
5. Fill job details:
   - Title: Full Stack Developer
   - Description: (copy from sample-data/sample_jd.txt)
   - Skills: React, Node.js, MongoDB
6. Upload resume files (or use sample-data/sample_resume.txt)
7. View ranked candidates!
8. Click "Send Interview Calls" (top 5 get emails)

## Common Issues & Solutions

### Issue: MongoDB Connection Error
**Solution:**
- Local MongoDB: Make sure MongoDB is running (`mongod`)
- Atlas: Check connection string in .env
- Check firewall settings

### Issue: Email Not Sending
**Solution:**
- Use Gmail app password, not regular password
- Enable 2-Step Verification first
- Check EMAIL_USER and EMAIL_PASS in .env

### Issue: Port Already in Use
**Solution:**
```bash
# Kill process on port 5000
lsof -ti:5000 | xargs kill

# Or change PORT in backend/.env
PORT=5001
```

### Issue: Python Module Not Found
**Solution:**
```bash
cd ai-engine
pip install -r requirements.txt --break-system-packages
# Or use virtual environment:
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

## Video Tutorial Structure (if you want to create one)

1. **Introduction** (2 min)
   - What is SmartRecruit?
   - Features overview

2. **Installation** (5 min)
   - Prerequisites
   - Running setup script
   - Environment configuration

3. **Candidate Flow** (3 min)
   - Registration
   - Resume upload
   - Viewing match score

4. **HR Flow** (5 min)
   - Job creation
   - Bulk resume upload
   - AI ranking results
   - Sending emails

5. **Code Walkthrough** (10 min)
   - Backend architecture
   - AI ranking algorithm
   - Frontend components

## Architecture Overview

```
┌─────────────┐
│   Browser   │  (React Frontend)
└──────┬──────┘
       │ HTTP/REST API
┌──────▼──────┐
│   Express   │  (Node.js Backend)
│   Server    │
└──────┬──────┘
       │
   ┌───┴───┬──────────┬──────────┐
   │       │          │          │
┌──▼───┐ ┌▼───────┐ ┌▼────────┐ ┌▼────────┐
│ JWT  │ │MongoDB │ │ Python  │ │Nodemailer│
│ Auth │ │Database│ │AI Engine│ │  Email  │
└──────┘ └────────┘ └─────────┘ └─────────┘
```

## File Upload Format

**Supported Formats:**
- Individual PDFs (.pdf)
- Individual Text files (.txt)
- ZIP containing multiple PDFs/TXTs

**Limits:**
- Single file: 5MB
- ZIP file: 50MB
- 100 files per ZIP

## API Testing with Postman/cURL

**Login:**
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"password123"}'
```

**Upload Resume:**
```bash
curl -X POST http://localhost:5000/api/candidate/upload-resume \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -F "resume=@/path/to/resume.pdf"
```

## Production Deployment Checklist

- [ ] Change JWT_SECRET to strong random string
- [ ] Use MongoDB Atlas or production MongoDB
- [ ] Set NODE_ENV=production
- [ ] Enable CORS for your domain only
- [ ] Use environment variables (never commit .env)
- [ ] Set up SSL/HTTPS
- [ ] Configure proper email service
- [ ] Set file upload limits
- [ ] Add rate limiting
- [ ] Set up monitoring and logging

## Need Help?

1. Check README.md for detailed documentation
2. Review troubleshooting section
3. Check MongoDB connection
4. Verify all environment variables
5. Check terminal logs for errors

---

**You're ready to go! Start recruiting with AI! 🚀**
