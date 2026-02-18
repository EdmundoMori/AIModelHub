# 🚀 AIModelHub

**AI Model Management Platform for Data Spaces**

EDC-compatible platform with Node.js runtime and Angular frontend for exploring, registering, and executing AI models with S3 storage, rich metadata, and real-time execution capabilities.

---

## 🎯 Project Status

**Version 2.4** - Plataforma prácticamente completa y operativa para el ciclo de vida de modelos IA en data spaces:
- ✅ Asset registration and discovery
- ✅ EDC-style policies and contracts
- ✅ Provider-consumer negotiations
- ✅ Model execution through HTTP endpoints
- ✅ Real-time execution monitoring
- ✅ Benchmarking system with 25 HTTP models (5 grupos compatibles)
- ✅ Unified schema-driven benchmark inputs with strict validation
- ✅ Obtain Outputs flow (single + dataset) with CSV/JSON downloads
- ✅ Mock server with grouped endpoints for comparative evaluation

---

## 📚 Documentation

### 📖 **[Complete Guide](GUIDE.md)** ← Start Here!

The complete guide includes:
- Features and architecture
- Quick start (one command deployment)
- Model execution tutorial
- Testing guide
- Troubleshooting
- Development workflow

---

## ⚡ Quick Start

```bash
# Clone repository
git clone <repository-url>
cd AIModelHub

# Deploy everything (3-5 minutes)
./deploy.sh

# Access application
# Frontend: http://localhost:4200
# Login: user-conn-user1-demo / user1123
```

---

## 🎯 Key Features

### Core Platform
- ✅ EDC-compatible backend with modular extensions
- ✅ Asset management and ML metadata
- ✅ PostgreSQL + MinIO S3 storage
- ✅ Angular 18 frontend
- ✅ Authentication and access control
- ✅ Contract definitions and catalog federation
- ✅ Validation datasets and task-aware metric configuration

### Model Execution & Benchmarking 🚀
- ✅ Execute models via HTTP REST API
- ✅ Visual execution dashboard
- ✅ Metadata-based input validation (types, required fields, min/max)
- ✅ Result visualization and history
- ✅ Benchmark ranking and comparative metrics
- ✅ Unified benchmark input form for compatible model groups
- ✅ Dataset batch execution and output export (CSV/JSON)
- ✅ Mock server with 25 benchmark-ready models
- ✅ Real-time execution monitoring

---

## 📁 Project Structure

```
AIModelHub/
├── deploy.sh                       # One-command deployment
├── GUIDE.md                        # Complete documentation
├── README.md                       # This file
│
├── AIModelHub_Extensiones/         # Backend logic
│   ├── backend/                    # Node.js + Express
│   │   ├── edc-extensions/        # Modular extensions
│   │   │   └── model-execution/   # NEW: Model execution
│   │   └── src/                   # Source code
│   ├── database/                   # PostgreSQL schemas
│   ├── model-server/               # Python mock server
│   └── docker-compose.yml         # Infrastructure
│
└── AIModelHub_EDCUI/              # Frontend
    └── ml-browser-app/            # Angular 18 UI
        └── src/app/pages/
            ├── ml-assets-browser/
            ├── model-execution/   # NEW: Execution UI
            ├── catalog/
            └── contracts/
```

---

## 🔧 Requirements

| Component | Version | Check |
|-----------|---------|-------|
| Docker | 20.10+ | `docker --version` |
| Node.js | 18+ | `node --version` |
| npm | 9+ | `npm --version` |
| Python | 3.8+ | `python3 --version` |

**Resources:** 2 CPU cores, 4 GB RAM, 10 GB disk

---

## 🌐 Services

After deployment:

| Service | URL | Credentials |
|---------|-----|-------------|
| **Frontend** | http://localhost:4200 | user-conn-user1-demo / user1123 |
| **Backend API** | http://localhost:3000 | - |
| **Mock Server** | http://localhost:8080 | - |
| **MinIO Console** | http://localhost:9001 | minioadmin / minioadmin123 |
| **PostgreSQL** | localhost:5432 | ml_assets_user / ml_assets_password |

---

## 🧪 Testing Model Execution

1. Open http://localhost:4200 and login
2. Click "IA Execution" in navigation menu to validate single-model execution
3. Select a model and run "Execute Model"
4. Verify outputs and execution history
5. Open "Model Benchmarking" to compare compatible model groups
6. Use "Validate Input" and "Obtain Outputs" (single or dataset mode)
7. Export dataset outputs in CSV/JSON format
8. Monitor runtime activity on http://localhost:8080

**See [GUIDE.md](GUIDE.md) for detailed testing scenarios**

---

## 📖 Documentation Structure

- **[GUIDE.md](GUIDE.md)** - Complete guide with all details
  - Architecture
  - Deployment
  - Model Execution
  - Testing
  - Troubleshooting
  - Development

---

## 🤝 Contributing

1. Read [GUIDE.md](GUIDE.md) - Contributing section
2. Create feature branch
3. Make changes
4. Test thoroughly
5. Submit pull request

---

## 🐛 Troubleshooting

Common issues and solutions in [GUIDE.md](GUIDE.md) - Troubleshooting section:
- Port conflicts
- Database connection errors
- Frontend compilation issues
- Model execution failures

---

## 🧹 System Maintenance

### Automated Cleanup

Run the cleanup script to maintain system health:

```bash
./cleanup-project.sh
```

**What it does**:
- 🗑️ Removes log files (optional)
- 🧹 Cleans temporary files (.tmp, .bak, *~)
- 🐍 Removes Python cache (__pycache__, *.pyc)
- ✅ Verifies database integrity (no duplicates)
- 📊 Shows project size analysis

### Database Health Check

```bash
# Check for duplicate data_addresses
docker exec ml-assets-postgres psql -U ml_assets_user -d ml_assets_db \
  -c "SELECT asset_id, COUNT(*) FROM data_addresses GROUP BY asset_id HAVING COUNT(*) > 1;"

# Expected: (0 rows) ← No duplicates
```

### Recent Optimizations (2026-02-18)

✅ **Database Cleanup**:
- Removed 30 duplicate rows from data_addresses (69 → 39)
- Eliminated 3 unused columns (folder_name, folder, path)
- Removed duplicate foreign key constraint
- Achieved perfect 1:1 ratio: assets ↔ data_addresses

✅ **Code & Feature Consolidation**:
- Removed obsolete SQL scripts
- Cleaned 92 __pycache__ directories
- Optimized project structure (843MB)
- Finalized model benchmarking UX for grouped, compatible schemas
- Added robust schema validation for single and dataset benchmark inputs
- Added dedicated OutPuts panel with normalized results and downloadable batches

📄 See [DEPURACION_REPORT.md](DEPURACION_REPORT.md) for complete details.

---

## 📋 Additional Documentation

- **[GUIDE.md](GUIDE.md)**: Complete setup and usage guide
- **[GUIA_PASO_A_PASO.md](GUIA_PASO_A_PASO.md)**: Guía detallada en español
- **[GUIA_ACCESO_CONECTORES.md](GUIA_ACCESO_CONECTORES.md)**: Guía de acceso a conectores
- **[25_MODELS_BENCHMARKING_GUIDE.md](25_MODELS_BENCHMARKING_GUIDE.md)**: Benchmarking system with 25 HTTP models
- **[DEPURACION_REPORT.md](DEPURACION_REPORT.md)**: Database cleanup and optimization report

---

---

## 📝 License

## 📝 License

AIModelHub is available under the **[Apache License 2.0](https://github.com/ProyectoPIONERA/AIModelHub/blob/main/LICENSE)**.

---

## 🙏 Acknowledgments

- Inspired by Eclipse Dataspace Components (EDC)
- Base technologies: Angular, Express/Node.js, PostgreSQL, MinIO

### Funding

This work has received funding from the **PIONERA project** (Enhancing interoperability in data spaces through artificial intelligence), a project funded in the context of the call for Technological Products and Services for Data Spaces of the Ministry for Digital Transformation and Public Administration within the framework of the PRTR funded by the European Union (NextGenerationEU).

<div align="center">
  <img src="funding_label.png" alt="Logos financiación" width="900" />
</div>

---

## 👥 Authors and Contact

- **Maintainers:** Edmundo Mori, Jiayun Liu
- **Contact:** 
  - edmundo.mori.orrillo@upm.es
  - jiayun.liu@alumnos.upm.es

---

**Last Updated:** February 18, 2026  
**Version:** 2.4.0
