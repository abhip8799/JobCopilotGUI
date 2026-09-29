from PyQt5.QtWidgets import QMainWindow, QLabel

class JobCopilotMainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("JobCopilotGUI")
        self.setGeometry(200, 200, 800, 600)
        label = QLabel("JobCopilotGUI Running", self)
        label.move(20, 20)
