---
name: create-lab-presentation
description: Creates interactive HTML presentations from markdown content about local hackers and security topics
allowed-tools: Read, Write, Bash(python3 *)
---

# Lab Presentation Creator

When creating presentations from lab documentation:

1. Read the input markdown file specified by the user
2. Extract key topics, structure, and headings
3. Generate an interactive HTML presentation with:
   - Professional title slide with topic name
   - Table of contents with navigation
   - Formatted sections with styling
   - Embedded images and links
   - Code blocks with syntax highlighting
   - Visual separators between sections
   - Navigation controls (previous/next)

4. Include professional styling for:
   - Clean, modern typography
   - Dark theme appropriate for technical/security content
   - Responsive layout that works on different screen sizes
   - Print-friendly formatting
   - Smooth transitions between slides

5. Use the generator.py script to automate the conversion process
6. Output the HTML file to the project directory with a clear filename

The presentation should be ready to open in any web browser and suitable for presenting technical security research.
