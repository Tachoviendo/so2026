#!/usr/bin/env python3
"""
Infographic Generator for Security Lab Documentation
Creates visual data representations from markdown files
"""

import sys
import re
import json

def extract_data(content):
    """Extract structured data from markdown content"""

    data = {
        'title': '',
        'attackers': [],
        'stats': [],
        'achievements': []
    }

    # Extract title
    title_match = re.search(r'^# (.+)$', content, re.MULTILINE)
    data['title'] = title_match.group(1) if title_match else 'Security Analysis'

    # Split by main sections (h2)
    sections = re.split(r'^## ', content, flags=re.MULTILINE)

    for section in sections[1:]:  # Skip first empty element
        lines = section.split('\n')
        section_title = lines[0].strip()
        section_content = '\n'.join(lines[1:])

        attacker = {
            'name': section_title,
            'description': '',
            'stats': [],
            'achievements': [],
            'profile': {}
        }

        # Extract profile information
        profile_matches = re.findall(r'\*\*(.+?)\*\*:\s*(.+)', section_content)
        for key, value in profile_matches:
            attacker['profile'][key] = value

        # Extract description (first paragraph)
        paragraphs = [p.strip() for p in section_content.split('\n\n') if p.strip() and not p.startswith('#')]
        if paragraphs:
            attacker['description'] = paragraphs[0].replace('**', '')

        # Extract numerical stats
        number_matches = re.findall(r'(\d+(?:,\d+)*(?:\.\d+)?)\s*(millones?|mil|GB|MB|datos?|registros?|archivos?)', section_content, re.IGNORECASE)
        for number, unit in number_matches:
            stat_context = re.search(rf'.{{0,50}}{re.escape(number)}.{{0,50}}', section_content)
            if stat_context:
                attacker['stats'].append({
                    'value': number,
                    'unit': unit,
                    'context': stat_context.group(0).strip()
                })

        # Extract achievements (numbered lists)
        achievements = re.findall(r'^\d+\.\s+(.+)$', section_content, re.MULTILINE)
        attacker['achievements'] = achievements

        # Extract sub-achievements (h3 sections)
        sub_achievements = re.findall(r'^### (.+)$', section_content, re.MULTILINE)
        attacker['achievements'].extend(sub_achievements)

        if attacker['description'] or attacker['stats'] or attacker['achievements']:
            data['attackers'].append(attacker)

    return data

def generate_infographic_html(data):
    """Generate HTML infographic"""

    attackers_html = ""

    for idx, attacker in enumerate(data['attackers']):
        # Color scheme based on index
        colors = [
            ('from-blue-600 to-blue-800', 'bg-blue-500'),
            ('from-red-600 to-red-800', 'bg-red-500'),
            ('from-purple-600 to-purple-800', 'bg-purple-500'),
            ('from-green-600 to-green-800', 'bg-green-500')
        ]
        gradient, accent = colors[idx % len(colors)]

        # Stats HTML
        stats_html = ""
        for stat in attacker['stats'][:3]:  # Limit to top 3 stats
            stats_html += f"""
            <div class="stat-box">
                <div class="stat-value">{stat['value']}</div>
                <div class="stat-unit">{stat['unit']}</div>
                <div class="stat-context">{stat['context'][:80]}...</div>
            </div>
            """

        # Achievements HTML
        achievements_html = ""
        for achievement in attacker['achievements'][:5]:  # Limit to top 5
            achievements_html += f"""
            <li class="achievement-item">
                <span class="achievement-bullet">▸</span>
                {achievement}
            </li>
            """

        # Profile HTML
        profile_html = ""
        for key, value in attacker['profile'].items():
            profile_html += f"""
            <div class="profile-item">
                <span class="profile-key">{key}:</span>
                <span class="profile-value">{value}</span>
            </div>
            """

        attackers_html += f"""
        <div class="attacker-card bg-gradient-{gradient}">
            <div class="card-header">
                <h2 class="attacker-name">{attacker['name']}</h2>
                <div class="threat-badge {accent}">THREAT ACTOR</div>
            </div>

            <div class="card-body">
                <p class="attacker-description">{attacker['description']}</p>

                {f'<div class="profile-section">{profile_html}</div>' if profile_html else ''}

                {f'<div class="stats-grid">{stats_html}</div>' if stats_html else ''}

                {f'<div class="achievements-section"><h3>Notable Actions</h3><ul class="achievements-list">{achievements_html}</ul></div>' if achievements_html else ''}
            </div>
        </div>
        """

    # Complete HTML template
    html = f"""<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{data['title']} - Infographic</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}

        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0a0a0a;
            color: #e0e0e0;
            padding: 20px;
            line-height: 1.6;
        }}

        .container {{
            max-width: 1400px;
            margin: 0 auto;
        }}

        .header {{
            text-align: center;
            padding: 60px 20px;
            background: linear-gradient(135deg, #1e3a8a 0%, #0f172a 100%);
            border-radius: 15px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }}

        .header h1 {{
            font-size: 3.5em;
            color: #60a5fa;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }}

        .header .subtitle {{
            font-size: 1.3em;
            color: #93c5fd;
            font-weight: 300;
        }}

        .attackers-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }}

        .attacker-card {{
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }}

        .attacker-card:hover {{
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.7);
        }}

        .bg-gradient-from-blue-600 {{
            background: linear-gradient(135deg, #2563eb 0%, #1e3a8a 100%);
        }}

        .bg-gradient-from-red-600 {{
            background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
        }}

        .bg-gradient-from-purple-600 {{
            background: linear-gradient(135deg, #9333ea 0%, #6b21a8 100%);
        }}

        .bg-gradient-from-green-600 {{
            background: linear-gradient(135deg, #059669 0%, #065f46 100%);
        }}

        .card-header {{
            padding: 30px;
            border-bottom: 2px solid rgba(255,255,255,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }}

        .attacker-name {{
            font-size: 2.2em;
            color: white;
            font-weight: 700;
        }}

        .threat-badge {{
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.8em;
            font-weight: 600;
            color: white;
            letter-spacing: 1px;
        }}

        .bg-blue-500 {{ background: #3b82f6; }}
        .bg-red-500 {{ background: #ef4444; }}
        .bg-purple-500 {{ background: #a855f7; }}
        .bg-green-500 {{ background: #10b981; }}

        .card-body {{
            padding: 30px;
            background: rgba(0,0,0,0.3);
        }}

        .attacker-description {{
            font-size: 1.1em;
            margin-bottom: 25px;
            color: #e5e7eb;
            line-height: 1.8;
        }}

        .profile-section {{
            background: rgba(0,0,0,0.2);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
        }}

        .profile-item {{
            margin-bottom: 10px;
            font-size: 1em;
        }}

        .profile-key {{
            color: #fbbf24;
            font-weight: 600;
            margin-right: 8px;
        }}

        .profile-value {{
            color: #d1d5db;
        }}

        .stats-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 25px;
        }}

        .stat-box {{
            background: rgba(0,0,0,0.4);
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            border: 2px solid rgba(255,255,255,0.1);
        }}

        .stat-value {{
            font-size: 2.5em;
            font-weight: 700;
            color: #fbbf24;
            margin-bottom: 5px;
        }}

        .stat-unit {{
            font-size: 1.1em;
            color: #93c5fd;
            font-weight: 600;
            margin-bottom: 10px;
        }}

        .stat-context {{
            font-size: 0.85em;
            color: #9ca3af;
            line-height: 1.4;
        }}

        .achievements-section {{
            background: rgba(0,0,0,0.2);
            padding: 20px;
            border-radius: 10px;
        }}

        .achievements-section h3 {{
            font-size: 1.5em;
            color: #fbbf24;
            margin-bottom: 15px;
        }}

        .achievements-list {{
            list-style: none;
        }}

        .achievement-item {{
            padding: 12px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            font-size: 1em;
            color: #d1d5db;
        }}

        .achievement-item:last-child {{
            border-bottom: none;
        }}

        .achievement-bullet {{
            color: #fbbf24;
            margin-right: 10px;
            font-weight: 700;
        }}

        .footer {{
            text-align: center;
            padding: 40px;
            color: #6b7280;
            font-size: 0.9em;
        }}

        @media print {{
            body {{
                background: white;
                color: black;
            }}
            .attacker-card {{
                page-break-inside: avoid;
                box-shadow: none;
                border: 1px solid #ccc;
            }}
        }}

        @media (max-width: 768px) {{
            .attackers-grid {{
                grid-template-columns: 1fr;
            }}
            .header h1 {{
                font-size: 2em;
            }}
            .attacker-name {{
                font-size: 1.5em;
            }}
            .stats-grid {{
                grid-template-columns: 1fr;
            }}
        }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>{data['title']}</h1>
            <p class="subtitle">Visual Security Analysis & Threat Intelligence</p>
        </div>

        <div class="attackers-grid">
            {attackers_html}
        </div>

        <div class="footer">
            <p>Generated from Lab02 Documentation | Security Research Analysis</p>
        </div>
    </div>
</body>
</html>"""

    return html

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 generator.py <input_markdown_file> [output_html_file]")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else input_file.replace('.md', '_infographic.html')

    # Read markdown file
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found")
        sys.exit(1)

    # Extract data and generate
    data = extract_data(content)
    html = generate_infographic_html(data)

    # Write output
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(html)

    print(f"✓ Infographic created: {output_file}")
    print(f"  Attackers analyzed: {len(data['attackers'])}")
    print(f"  Open in browser to view")

if __name__ == '__main__':
    main()
