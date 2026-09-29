Write-Host "Creating JobCopilotGUI project..." -ForegroundColor Cyan

$projectPath = "C:\JobCopilotGUI"
if (!(Test-Path $projectPath)) {
    New-Item -ItemType Directory -Path $projectPath | Out-Null
}

# --- main.py ---
@"
import sys
from PyQt5.QtWidgets import QApplication
from gui.main_window import JobCopilotMainWindow

def main():
    app = QApplication(sys.argv)
    window = JobCopilotMainWindow()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
"@ | Set-Content "$projectPath\main.py"

# --- requirements.txt ---
@"
PyQt5
requests
beautifulsoup4
python-docx
fpdf
"@ | Set-Content "$projectPath\requirements.txt"

# --- Create folders ---
New-Item -ItemType Directory -Path "$projectPath\gui" -Force | Out-Null
New-Item -ItemType Directory -Path "$projectPath\core" -Force | Out-Null
New-Item -ItemType Directory -Path "$projectPath\ai" -Force | Out-Null
New-Item -ItemType Directory -Path "$projectPath\data" -Force | Out-Null

# --- gui/main_window.py ---
@"
from PyQt5.QtWidgets import QMainWindow, QLabel

class JobCopilotMainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("JobCopilotGUI")
        self.setGeometry(200, 200, 800, 600)
        label = QLabel("JobCopilotGUI Running", self)
        label.move(20, 20)
"@ | Set-Content "$projectPath\gui\main_window.py"

# --- core/tracker.py ---
@"
class JobTracker:
    def track(self):
        return "Tracking jobs..."
"@ | Set-Content "$projectPath\core\tracker.py"

# --- core/ai_client.py ---
@"
class AIClient:
    def ask(self, prompt):
        return "AI Response"
"@ | Set-Content "$projectPath\core\ai_client.py"

# --- core/generator.py ---
@"
class Generator:
    def generate(self):
        return "Generated content"
"@ | Set-Content "$projectPath\core\generator.py"

# --- ai/prompts.py ---
@"
PROMPT = "Write a resume"
"@ | Set-Content "$projectPath\ai\prompts.py"

# --- data/profiles.json ---
@"
{}
"@ | Set-Content "$projectPath\data\profiles.json"

Write-Host "Initializing Git..." -ForegroundColor Yellow
Set-Location $projectPath

git init
git remote add origin https://github.com/abhip8799/JobCopilotGUI.git
git checkout -b main

git add .
git commit -m "Auto-created JobCopilotGUI project"
git push -u origin main

Write-Host "Installing Python requirements..." -ForegroundColor Yellow
pip install -r requirements.txt

Write-Host "Pulling mistral model..." -ForegroundColor Yellow
ollama pull mistral

Write-Host "Launching JobCopilotGUI..." -ForegroundColor Cyan
python main.py
