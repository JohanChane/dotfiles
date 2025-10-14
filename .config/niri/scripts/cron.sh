#!/usr/bin/env python3
import subprocess, os
import time
import threading
from dataclasses import dataclass
from typing import List

@dataclass
class CronTask:
    name: str
    command: str
    interval: int  # seconds interval
    run_initially: bool

    def execute(self):
        """Execute task"""
        try:
            result = subprocess.run(
                self.command,
                shell=True,
                capture_output=True,
                text=True,
                timeout=300  # 5 minutes timeout
            )
            timestamp = time.strftime('%H:%M:%S')
            status = "✓" if result.returncode == 0 else "✗"
            print(f"[{timestamp}] {status} {self.name}")

            if result.stdout.strip():
                print(f"      Output: {result.stdout.strip()}")
            if result.stderr.strip():
                print(f"      Error: {result.stderr.strip()}")

        except subprocess.TimeoutExpired:
            print(f"[{time.strftime('%H:%M:%S')}] ⏰ {self.name} execution timeout")
        except Exception as e:
            print(f"[{time.strftime('%H:%M:%S')}] ✗ {self.name}: {e}")

SCRIPT_DIR = os.path.expanduser('~/.config/niri/scripts')

# Task configuration - interval in seconds
tasks: List[CronTask] = [
    CronTask('wallpaper', (
      f'{SCRIPT_DIR}/wallpaper.sh'
      ' --dir $HOME/My/Workspace/Src/Projects/wallpaper.yaocccc'
      ' --dir $HOME/My/Workspace/Src/Projects/aesthetic-wallpapers/images'
    ), 5 * 60, True),
]

def run_task(task: CronTask):
    """Function to run a single task"""
    if task.run_initially:
        task.execute()
    while True:
        time.sleep(task.interval)  # use seconds directly
        task.execute()

def start_scheduler():
    print("=== Task Scheduler ===")

    for task in tasks:
        # Pass task parameter directly to avoid closure issues
        thread = threading.Thread(
            target=run_task,
            args=(task,),  # pass task as argument
            daemon=True,
            name=task.name
        )
        thread.start()

    # Keep main thread running
    try:
        while True:
            time.sleep(1)  # check every 1 second
    except KeyboardInterrupt:
        print("\nExiting program...")

if __name__ == "__main__":
    start_scheduler()
