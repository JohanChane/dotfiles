#!/usr/bin/env python3

import os
import sys
import random
import subprocess
import argparse
from pathlib import Path

# Configuration
BG_COLOR = '#30404E'
SUPPORTED_EXTENSIONS = {'.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'}


def find_wallpapers_in_directory(directory):
    """
    Find all supported image files in the specified directory and its subdirectories.

    Args:
        directory: The directory path to search

    Returns:
        List of image file paths
    """
    wallpapers = []
    try:
        dir_path = Path(directory)

        # Check if directory exists (including symbolic links)
        if not dir_path.exists():
            print(f"Warning: Directory {directory} does not exist", file=sys.stderr)
            return wallpapers

        # Resolve symbolic links to get the actual directory path
        resolved_dir = dir_path.resolve()

        if not resolved_dir.is_dir():
            print(f"Warning: Resolved directory {resolved_dir} is not a valid directory", file=sys.stderr)
            return wallpapers

        # Find image files in the directory and all its subdirectories
        for ext in SUPPORTED_EXTENSIONS:
            # Find all extension variants (case insensitive)
            wallpapers.extend(resolved_dir.rglob(f"*{ext}"))
            wallpapers.extend(resolved_dir.rglob(f"*{ext.upper()}"))
            # For mixed case scenarios, use a more general approach
            wallpapers.extend([p for p in resolved_dir.rglob("*")
                             if p.suffix.lower() == ext.lower()])

    except Exception as e:
        print(f"Error searching directory {directory}: {e}", file=sys.stderr)

    return wallpapers


def get_random_wallpaper(directories):
    """
    Randomly select a wallpaper file from multiple directories.

    Args:
        directories: List of directory paths to search

    Returns:
        Path object of the selected wallpaper, or None if error occurs
    """
    all_wallpapers = []

    for directory in directories:
        print(f"Searching for wallpapers in: {directory}")
        wallpapers = find_wallpapers_in_directory(directory)

        # Filter out directories and unreadable files, add directly to list
        valid_wallpapers = [wp for wp in wallpapers if wp.is_file() and os.access(wp, os.R_OK)]
        all_wallpapers.extend(valid_wallpapers)

        print(f"  Found {len(valid_wallpapers)} wallpapers in this directory")

    # Check if any wallpapers were found
    if not all_wallpapers:
        print("Error: No wallpaper files found in any of the specified directories", file=sys.stderr)
        return None

    print(f"Total wallpapers found: {len(all_wallpapers)}")

    # Randomly select a wallpaper
    selected = random.choice(all_wallpapers)
    return selected


def main():
    """Main function: Set random wallpaper"""
    parser = argparse.ArgumentParser(description='Set random wallpaper using swaybg, supports multiple directories')
    parser.add_argument('--dir', '--directory', type=Path, action='append',
                       required=True, dest='directories',
                       help='Wallpaper directory (at least one required, can be used multiple times to specify multiple directories)')
    parser.add_argument('--color', default=BG_COLOR, help='Background color')
    parser.add_argument('--list-dirs', action='store_true',
                       help='Show directories being searched and exit')

    args = parser.parse_args()

    # Determine directories to search
    search_directories = [str(path) for path in args.directories]

    if args.list_dirs:
        print("Searching in the following directories:")
        for directory in search_directories:
            print(f"  {directory}")
        return

    # Check if at least one valid directory exists
    valid_directories = [d for d in search_directories if Path(d).exists()]
    if not valid_directories:
        print("Error: None of the specified directories exist", file=sys.stderr)
        print("Please check the paths and try again.", file=sys.stderr)
        sys.exit(1)

    wallpaper_path = get_random_wallpaper(valid_directories)

    # Check if wallpaper was successfully obtained and file exists
    if wallpaper_path and wallpaper_path.exists():
        try:
            # Terminate existing swaybg processes
            subprocess.run(['pkill', 'swaybg'], capture_output=True)

            # Start swaybg to set wallpaper, using fill mode and background color
            subprocess.Popen([
                'swaybg',
                '-i', str(wallpaper_path),
                '-m', 'fill',
                '-c', args.color
            ])

            print(f"Wallpaper set: {wallpaper_path}")

        except subprocess.SubprocessError as e:
            print(f"Error executing command: {e}", file=sys.stderr)
            sys.exit(1)
        except FileNotFoundError:
            print("Error: swaybg not found. Please make sure it's installed.", file=sys.stderr)
            sys.exit(1)
    else:
        print("Failed to set wallpaper", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
