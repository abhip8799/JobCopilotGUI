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
