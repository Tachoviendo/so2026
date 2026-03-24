#!/usr/bin/env python3
"""
HTML Presentation Generator for Lab Documentation
Converts markdown files into interactive HTML presentations
"""

import sys
import re
import os

def parse_markdown(content):
    """Parse markdown content into structured sections"""
    lines = content.split('\n')
    sections = []
    current_section = {'title': '', 'content': [], 'level': 0}

    for line in lines:
        # Check for headers
        h1_match = re.match(r'^# (.+)$', line)
        h2_match = re.match(r'^## (.+)$', line)
        h3_match = re.match(r'^### (.+)$', line)

        if h1_match:
            if current_section['content'] or current_section['title']:
                sections.append(current_section)
            current_section = {'title': h1_match.group(1), 'content': [], 'level': 1}
        elif h2_match:
            if current_section['content'] or current_section['title']:
                sections.append(current_section)
            current_section = {'title': h2_match.group(1), 'content': [], 'level': 2}
        elif h3_match:
            if current_section['content'] or current_section['title']:
                sections.append(current_section)
            current_section = {'title': h3_match.group(1), 'content': [], 'level': 3}
        else:
            current_section['content'].append(line)

    if current_section['content'] or current_section['title']:
        sections.append(current_section)

    return sections

def format_content(content):
    """Format markdown content to HTML"""
    html = '\n'.join(content)

    # Bold
    html = re.sub(r'\*\*(.+?)\*\*', r'<strong>\1</strong>', html)

    # Links
    html = re.sub(r'\[(.+?)\]\((.+?)\)', r'<a href="\2" target="_blank">\1</a>', html)

    # Images
    html = re.sub(r'!\[(.+?)\]\((.+?)\)', r'<img src="\2" alt="\1" class="slide-image">', html)

    # Lists
    html = re.sub(r'^\d+\.\s+(.+)$', r'<li>\1</li>', html, flags=re.MULTILINE)
    html = re.sub(r'(<li>.*</li>)', r'<ol>\1</ol>', html, flags=re.DOTALL)
    html = html.replace('</li>\n<li>', '</li><li>')

    # Paragraphs
    paragraphs = html.split('\n\n')
    formatted_paragraphs = []
    for p in paragraphs:
        p = p.strip()
        if p and not p.startswith('<') and not p.startswith('!'):
            formatted_paragraphs.append(f'<p>{p}</p>')
        elif p:
            formatted_paragraphs.append(p)

    return '\n'.join(formatted_paragraphs)

def generate_html(sections, title):
    """Generate complete HTML presentation"""

    slides_html = ""

    # Title slide
    slides_html += f"""
    <div class="slide title-slide">
        <h1>{title}</h1>
        <p class="subtitle">Investigación de Seguridad - Lab02</p>
    </div>
    """

    # Content slides
    for i, section in enumerate(sections):
        if not section['title']:
            continue

        level_class = f"level-{section['level']}"
        content_html = format_content(section['content'])

        slides_html += f"""
    <div class="slide {level_class}">
        <h2>{section['title']}</h2>
        <div class="slide-content">
            {content_html}
        </div>
    </div>
    """

    # Complete HTML template
    html_template = f"""<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title} - Presentación</title>
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
            overflow-x: hidden;
        }}

        .presentation {{
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }}

        .slide {{
            min-height: 100vh;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-bottom: 2px solid #222;
            background: linear-gradient(135deg, #1a1a1a 0%, #0d0d0d 100%);
            margin-bottom: 2px;
        }}

        .title-slide {{
            background: linear-gradient(135deg, #1e3a8a 0%, #0f172a 100%);
            text-align: center;
        }}

        .title-slide h1 {{
            font-size: 4em;
            margin-bottom: 20px;
            color: #60a5fa;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }}

        .subtitle {{
            font-size: 1.5em;
            color: #93c5fd;
            font-weight: 300;
        }}

        .slide h2 {{
            font-size: 2.5em;
            margin-bottom: 30px;
            color: #60a5fa;
            border-bottom: 3px solid #1e40af;
            padding-bottom: 15px;
        }}

        .slide-content {{
            font-size: 1.3em;
            line-height: 1.8;
            color: #d1d5db;
        }}

        .slide-content p {{
            margin-bottom: 20px;
        }}

        .slide-content strong {{
            color: #fbbf24;
            font-weight: 600;
        }}

        .slide-content a {{
            color: #60a5fa;
            text-decoration: none;
            border-bottom: 1px solid #60a5fa;
            transition: all 0.3s ease;
        }}

        .slide-content a:hover {{
            color: #93c5fd;
            border-bottom-color: #93c5fd;
        }}

        .slide-content ol {{
            margin-left: 40px;
            margin-bottom: 20px;
        }}

        .slide-content li {{
            margin-bottom: 15px;
            padding-left: 10px;
        }}

        .slide-image {{
            max-width: 100%;
            height: auto;
            margin: 30px 0;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.4);
        }}

        .level-2 {{
            background: linear-gradient(135deg, #1a1a2e 0%, #0f0f1e 100%);
        }}

        .level-3 {{
            background: linear-gradient(135deg, #1e1a1a 0%, #0f0d0d 100%);
        }}

        .navigation {{
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 1000;
        }}

        .nav-button {{
            background: #1e40af;
            color: white;
            border: none;
            padding: 15px 25px;
            margin: 5px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
        }}

        .nav-button:hover {{
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.4);
        }}

        .slide-counter {{
            position: fixed;
            bottom: 30px;
            left: 30px;
            background: rgba(30, 64, 175, 0.8);
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1.1em;
            z-index: 1000;
        }}

        @media print {{
            .slide {{
                page-break-after: always;
                min-height: auto;
            }}
            .navigation, .slide-counter {{
                display: none;
            }}
        }}

        @media (max-width: 768px) {{
            .slide h2 {{
                font-size: 2em;
            }}
            .title-slide h1 {{
                font-size: 2.5em;
            }}
            .slide-content {{
                font-size: 1.1em;
            }}
        }}
    </style>
</head>
<body>
    <div class="presentation">
        {slides_html}
    </div>

    <div class="slide-counter" id="slideCounter">Slide 1</div>

    <div class="navigation">
        <button class="nav-button" onclick="scrollToSlide('prev')">◀ Anterior</button>
        <button class="nav-button" onclick="scrollToSlide('next')">Siguiente ▶</button>
    </div>

    <script>
        let currentSlide = 0;
        const slides = document.querySelectorAll('.slide');

        function updateCounter() {{
            document.getElementById('slideCounter').textContent = `Slide ${{currentSlide + 1}} / ${{slides.length}}`;
        }}

        function scrollToSlide(direction) {{
            if (direction === 'next' && currentSlide < slides.length - 1) {{
                currentSlide++;
            }} else if (direction === 'prev' && currentSlide > 0) {{
                currentSlide--;
            }}

            slides[currentSlide].scrollIntoView({{ behavior: 'smooth' }});
            updateCounter();
        }}

        // Keyboard navigation
        document.addEventListener('keydown', (e) => {{
            if (e.key === 'ArrowRight' || e.key === 'ArrowDown') {{
                scrollToSlide('next');
            }} else if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') {{
                scrollToSlide('prev');
            }}
        }});

        // Update counter on scroll
        let scrollTimeout;
        window.addEventListener('scroll', () => {{
            clearTimeout(scrollTimeout);
            scrollTimeout = setTimeout(() => {{
                const scrollPosition = window.scrollY + window.innerHeight / 2;
                slides.forEach((slide, index) => {{
                    const rect = slide.getBoundingClientRect();
                    const slideTop = window.scrollY + rect.top;
                    const slideBottom = slideTop + rect.height;

                    if (scrollPosition >= slideTop && scrollPosition < slideBottom) {{
                        currentSlide = index;
                        updateCounter();
                    }}
                }});
            }}, 100);
        }});

        updateCounter();
    </script>
</body>
</html>"""

    return html_template

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 generator.py <input_markdown_file> [output_html_file]")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else input_file.replace('.md', '_presentation.html')

    # Read markdown file
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found")
        sys.exit(1)

    # Extract title (first h1 or filename)
    title_match = re.search(r'^# (.+)$', content, re.MULTILINE)
    title = title_match.group(1) if title_match else os.path.splitext(os.path.basename(input_file))[0]

    # Parse and generate
    sections = parse_markdown(content)
    html = generate_html(sections, title)

    # Write output
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(html)

    print(f"✓ Presentation created: {output_file}")
    print(f"  Total slides: {len([s for s in sections if s['title']]) + 1}")
    print(f"  Open in browser to view")

if __name__ == '__main__':
    main()
