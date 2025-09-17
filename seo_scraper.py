import requests
from bs4 import BeautifulSoup
import logging

logging.basicConfig(level=logging.INFO)

def get_page_head(url):
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124'}
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        head = soup.find('head')
        if not head:
            return {"error": "No <head> tag found"}
        # Parse title, meta, link, script tags
        result = {}
        title_tag = head.find('title')
        result['title'] = title_tag.text if title_tag else None
        # Extract all meta tags
        all_meta = [dict(tag.attrs) for tag in head.find_all('meta')]
        result['meta'] = all_meta

        # Highlight important SEO-related meta attributes
        seo_meta = {}
        for tag in all_meta:
            # Description
            if tag.get('name', '').lower() == 'description':
                seo_meta['description'] = tag.get('content')
            # Robots
            if tag.get('name', '').lower() == 'robots':
                seo_meta['robots'] = tag.get('content')
            # Viewport
            if tag.get('name', '').lower() == 'viewport':
                seo_meta['viewport'] = tag.get('content')
            # Charset
            if 'charset' in tag:
                seo_meta['charset'] = tag.get('charset')
            # Open Graph
            if tag.get('property', '').startswith('og:'):
                seo_meta[tag['property']] = tag.get('content')
            # Twitter Card
            if tag.get('name', '').startswith('twitter:'):
                seo_meta[tag['name']] = tag.get('content')
        result['seo_meta'] = seo_meta

        # Extract all link tags
        result['link'] = [dict(tag.attrs) for tag in head.find_all('link')]
        return result
    except requests.RequestException as e:
        logging.error(f"Error fetching {url}: {e}")
        return f"Error fetching {url}: {e}"

def scrape_websites(websites):
    import json
    results = []
    for i, url in enumerate(websites, 1):
        print(f"\nWebsite {i}: {url}")
        head_content = get_page_head(url)
        print("Head content (JSON):")
        print(json.dumps(head_content, indent=2, ensure_ascii=False))
        print("-" * 80)
        results.append({"url": url, "head": head_content})

    # Write all results to a file
    with open("seo_results.json", "a", encoding="utf-8") as f:
        for entry in results:
            f.write(json.dumps(entry, ensure_ascii=False))
            f.write("\n")

if __name__ == "__main__":
    # Replace with your list of websites
    websites = [
        # Family photography in toronto
        "https://www.ten2tenphotography.com/toronto-family-photographer/",
        "https://mangostudios.com/family-portrait/",
        "https://www.jenninkol.com/",
        "https://beesportraitphotography.com/",
        "https://www.jessgc.com/",

        # Headshot photographer in toronto
        "https://www.kingstreetphotostudio.com/",
        "https://www.actorheadshots.ca/",
        "https://calvinthomas.ca/",
        "https://www.headshotsto.com/",

        # Newborn photography in toronto
        "https://clairebinksphotography.com/",
        "https://alonarose.com/toronto-newborn-photographer/",
        "https://alittleonetoronto.com/",
        "https://peekaboostudios.ca/",

        # Maternity Photography in toronto
        "https://juliapark.ca/",
        "https://www.kristenborelliphotography.com/",
        "https://www.allysphotography.com/",
        "https://lilacstudios.ca/familyphotography/",

        # Milestone Photography in toronto
        "https://www.babystudio.ca/milestone-photography",
        "https://lilonephotography.com/milestone/",
        "https://www.albm.ca/milestone/",
        "https://alittleonetoronto.com/baby-kids-photography3-month-1-year-old/",

        # Child photographer in toronto
        "https://www.pamelayool.com/",
        "https://www.preciousonesphotography.ca/",
        "https://www.littleicons.com/toronto-area-child-photographer",

        # Cake Smash Photographer in toronot
        "https://www.jamielucas.com/cake-smash",
        "https://anythinggoesphotography.com/toronto-cake-smash-photographer",
        "https://www.stephaniehopephotography.ca/cake-smash-photography",
        "https://alexannesolomon.com/gallery/cake-smash/",
        "https://anchorstudio.ca/",
    ]
    scrape_websites(websites)