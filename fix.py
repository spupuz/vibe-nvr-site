import re

with open("src/scripts.html", "r") as f:
    text = f.read()

text = re.sub(r'if \(!vid\) \{\n\s*if \(window.crypto && window.crypto.randomUUID\) \{\n\s*// 🛡️ Sentinel: Use cryptographically secure random UUID if available, fallback to Math.random', 
r'if (!vid) {\n                    // 🛡️ Sentinel: Use cryptographically secure random UUID if available, fallback to Math.random', text)

with open("src/scripts.html", "w") as f:
    f.write(text)
