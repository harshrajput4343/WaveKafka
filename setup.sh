#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Real-Time Data Pipeline Environment...${NC}"

# 1. Start Docker Containers
echo -e "${GREEN}Step 1: Starting Docker Containers (Kafka, Zookeeper, Postgres, Spark)...${NC}"
docker compose up -d

echo -e "${GREEN}Waiting for containers to initialize (15 seconds)...${NC}"
sleep 15

# 2. Create and Activate Virtual Environment
echo -e "${GREEN}Step 2: Creating Python Virtual Environment...${NC}"
python3 -m venv venv
source venv/bin/activate

# 3. Install Python Dependencies
echo -e "${GREEN}Step 3: Installing Python Dependencies...${NC}"
pip install -r requirements.txt

# 4. Initialize Database
echo -e "${GREEN}Step 4: Initializing Database...${NC}"
python init_db.py

echo -e "${GREEN}Setup Complete!${NC}"
echo ""
echo "============================================================"
echo "   HOW TO RUN THIS PROJECT - Step by Step Commands"
echo "============================================================"
echo ""
echo "--- STEP 1: Pull Docker Images ---"
echo "   docker compose pull"
echo ""
echo "--- STEP 2: Start All Containers ---"
echo "   docker compose up -d"
echo ""
echo "--- STEP 3: Wait for containers to initialize ---"
echo "   sleep 15"
echo ""
echo "--- STEP 4: Create & Activate Virtual Environment ---"
echo "   [Linux/Mac]  python3 -m venv venv && source venv/bin/activate"
echo "   [Windows]     python -m venv venv && .\venv\Scripts\activate"
echo ""
echo "--- STEP 5: Install Dependencies ---"
echo "   pip install -r requirements.txt"
echo "   pip install faker"
echo ""
echo "--- STEP 6: Initialize Database ---"
echo "   python init_db.py"
echo ""
echo "--- STEP 7: Run the Pipeline (open 3 separate terminals) ---"
echo ""
echo "   Terminal 1 - Producer (sends fake transactions to Kafka):"
echo "      source venv/bin/activate && python producer.py"
echo ""
echo "   Terminal 2 - Spark Processor (aggregates data & writes to DB):"
echo "      source venv/bin/activate && python spark_processor.py"
echo ""
echo "   Terminal 3 - Dashboard (live Streamlit UI):"
echo "      source venv/bin/activate && streamlit run dashboard.py"
echo ""
echo "--- STEP 8: Open Dashboard ---"
echo "   Visit: http://localhost:8501"
echo ""
echo "============================================================"
echo "   WINDOWS-SPECIFIC PREREQUISITES"
echo "============================================================"
echo ""
echo "   1. Install Java 17 (64-bit):"
echo "      winget install --id EclipseAdoptium.Temurin.17.JDK"
echo ""
echo "   2. Download Hadoop binaries for Windows:"
echo "      mkdir C:\hadoop\bin"
echo "      Download winutils.exe and hadoop.dll from:"
echo "      https://github.com/kontext-tech/winutils/tree/master/hadoop-3.3.1/bin"
echo "      Place them in C:\hadoop\bin\"
echo ""
echo "   3. Set environment variables before running Spark:"
echo "      \$env:JAVA_HOME = \"C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot\""
echo "      \$env:HADOOP_HOME = \"C:\hadoop\""
echo "      \$env:PATH = \"\$env:JAVA_HOME\bin;\$env:HADOOP_HOME\bin;\$env:PATH\""
echo ""
echo "   4. If local PostgreSQL conflicts on port 5432,"
echo "      the Docker PostgreSQL is mapped to port 5433."
echo ""
echo "============================================================"
echo "   TO STOP EVERYTHING"
echo "============================================================"
echo "   docker compose down        # Stop containers"
echo "   docker compose down -v     # Stop containers + delete data"
echo "============================================================"
echo ""
echo ""
echo "============================================================"
echo "   EXACT COMMANDS USED ON WINDOWS (PowerShell)"
echo "============================================================"
echo ""
echo "# 1. Pull all Docker images"
echo "   docker compose pull"
echo ""
echo "# 2. Start all containers in detached mode"
echo "   docker compose up -d"
echo ""
echo "# 3. Wait for containers to be ready"
echo "   Start-Sleep -Seconds 15"
echo ""
echo "# 4. Create Python virtual environment"
echo "   python -m venv venv"
echo ""
echo "# 5. Install Python dependencies"
echo '   .\venv\Scripts\pip.exe install -r requirements.txt'
echo '   .\venv\Scripts\pip.exe install faker'
echo ""
echo "# 6. Initialize the database (creates category_sales table)"
echo '   .\venv\Scripts\python.exe init_db.py'
echo ""
echo "# 7. Install Java 17 64-bit (required by PySpark 3.5)"
echo "   winget install --id EclipseAdoptium.Temurin.17.JDK"
echo ""
echo "# 8. Download Hadoop Windows binaries (required by Spark on Windows)"
echo "   mkdir C:\hadoop\bin -Force"
echo '   Invoke-WebRequest -Uri "https://github.com/kontext-tech/winutils/raw/master/hadoop-3.3.1/bin/winutils.exe" -OutFile "C:\hadoop\bin\winutils.exe"'
echo '   Invoke-WebRequest -Uri "https://github.com/kontext-tech/winutils/raw/master/hadoop-3.3.1/bin/hadoop.dll" -OutFile "C:\hadoop\bin\hadoop.dll"'
echo ""
echo "# 9. Set environment variables (run this in EVERY new terminal)"
echo '   $env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot"'
echo '   $env:HADOOP_HOME = "C:\hadoop"'
echo '   $env:PATH = "$env:JAVA_HOME\bin;$env:HADOOP_HOME\bin;$env:PATH"'
echo ""
echo "# 10. Run Producer (Terminal 1)"
echo '   .\venv\Scripts\python.exe producer.py'
echo ""
echo "# 11. Run Spark Processor (Terminal 2)"
echo '   .\venv\Scripts\python.exe spark_processor.py'
echo ""
echo "# 12. Run Streamlit Dashboard (Terminal 3)"
echo '   .\venv\Scripts\streamlit.exe run dashboard.py'
echo ""
echo "# 13. Open browser"
echo "   http://localhost:8501"
echo ""
echo "============================================================"
