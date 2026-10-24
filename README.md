# MC 451 Final Portfolio — Setup & Publishing Guide

**Course:** MC 451 Research Methods in Mass Media \| Spring 2026\
**Instructor:** Dr. Alex P. Leith \| aleith\@siue.edu\
**Due:** Friday, May 8, 2026 at 11:59 pm

------------------------------------------------------------------------

## What This Project Does

This folder is a **Quarto Book Project**. With a single command, it renders your research report into two professional outputs simultaneously:

| Output | What It Produces | Where It Goes |
|------------------------|------------------------|------------------------|
| 🌐 **Website** | A multi-page, navigable site | `docs/` folder → GitHub Pages |
| 📄 **PDF** | A single print-ready document | `docs/` folder → submit to Blackboard |

You write your content **once** in plain text (`.qmd` files). Quarto handles the formatting for both outputs automatically.

------------------------------------------------------------------------

## Project File Map

```         
mc451-final-project/
│
├── 📋 _quarto.yml              ← Master config. Controls both outputs.
│                                  UPDATE: title, author, repo-url
│
├── 🏠 index.qmd                ← Page 1: Abstract + landing page
├── 📖 01-introduction.qmd      ← Page 2: Background, theory, RQs
├── 🔬 02-methodology.qmd       ← Page 3: Data, sample, variables, pilot
├── 📊 03-results.qmd           ← Page 4: Tables, bar chart, Chi-Square
├── 💬 04-discussion.qmd        ← Page 5: Interpretation + conclusion
├── 📚 references.qmd           ← Page 6: Auto-generated bibliography
│
├── 🎨 custom.css               ← Website styling. No edits needed.
├── 📝 references.bib           ← Your citations (export from Zotero)
├── 📐 GET-APA-CSL.txt          ← Instructions to download apa.csl
│
└── 💾 coding_data_clean.RDS    ← ⚠️ ADD THIS FILE — your R data
```

------------------------------------------------------------------------

## Before You Start: One-Time Setup

Complete these steps **once** before you write anything.

### Step 1 — Place your data file

Copy your `coding_data_clean.RDS` file (produced in Data Wrangling \[R\]) into this project folder — the same level as `_quarto.yml`.

> **Where is my .RDS file?** In RStudio, you saved it with: `saveRDS(coding_data, "coding_data_clean.RDS")` It is wherever your RStudio Project was set at the time.

### Step 2 — Open as an RStudio Project

1.  In RStudio: **File → Open Project**
2.  Navigate to this folder and open `mc451-final-project.Rproj`

> **Don't see an .Rproj file?** Create one: **File → New Project → Existing Directory** → select this folder.

### Step 3 — Install required R packages

In the RStudio Console, run:

``` r
install.packages(c(
  "tidyverse",
  "knitr",
  "kableExtra",
  "scales"
))
```

### Step 4 — Get the APA citation style file

Follow the instructions in `GET-APA-CSL.txt` to download `apa.csl` into this folder. Then delete `GET-APA-CSL.txt`.

### Step 5 — Update `_quarto.yml`

Open `_quarto.yml` and change these three lines:

``` yaml
title: "Your Actual Study Title: A Content Analysis of X Coverage of Y"
author: "Your Full Name"
repo-url: https://github.com/YOUR-USERNAME/YOUR-REPO-NAME
```

------------------------------------------------------------------------

## How to Write Your Report

Each `.qmd` file is one chapter/page of your report. Open them in order and follow the instructions inside. Every file contains:

-   🟩 **Green instruction comments** (`<!-- like this -->`) — read them, then delete them before your final render
-   **\[BRACKETED PLACEHOLDERS\]** — replace with your actual content
-   **`← replace` comments in R code chunks** — swap variable names for your real column names

### The writing order we recommend:

1.  `02-methodology.qmd` — easiest starting point; draws directly from your Codebook and Sampling Plan
2.  `01-introduction.qmd` — expand your Prospectus; add theory from Annotated Manuscript
3.  `03-results.qmd` — paste your .RDS file in and update variable names; let the code run
4.  `04-discussion.qmd` — interpret your Results; answer the RQs
5.  `index.qmd` — write the Abstract last, once everything else is done

### Working with R code chunks in the Results chapter

The `03-results.qmd` file contains pre-written R code. The **only changes you need to make** are:

1.  Replace `var1` with your first variable's column name (e.g., `tone`)
2.  Replace `var2` with your second variable's column name (e.g., `source_type`)
3.  Update chart titles, axis labels, and figure captions to describe your actual variables
4.  Adjust the color palette if you have more or fewer categories than the defaults

> **To see what your column names are**, run this in the RStudio Console: `names(readRDS("coding_data_clean.RDS"))`

------------------------------------------------------------------------

## Rendering: From Files to PDF + Website

### Test render (do this often while writing)

In the RStudio Terminal tab (not the Console), run:

``` bash
quarto render
```

This generates everything in the `docs/` folder. Open `docs/index.html` in your browser to preview the website. Open `docs/Study-Title.pdf` (or similar name) to check the PDF.

### If the render fails

The most common issues and fixes:

| Error Message | Fix |
|------------------------------------|------------------------------------|
| `object 'var1' not found` | You have not replaced the placeholder variable name in a code chunk |
| `cannot open file 'coding_data_clean.RDS'` | The .RDS file is not in the project folder |
| `citation 'CITATION' not found` | The `@CITATION` key in your text does not match any entry in `references.bib` |
| `apa.csl not found` | You have not completed Step 4 above |
| Package not found | Run `install.packages("PACKAGE_NAME")` in the Console |

------------------------------------------------------------------------

## Publishing to GitHub Pages

### First time: Create your repository

1.  Go to [github.com](https://github.com) and sign in
2.  Click **New Repository**
3.  Name it `mc451-portfolio` (or any name you prefer)
4.  Set it to **Public**
5.  Do **not** initialize with a README (you already have files)
6.  Click **Create Repository**

### Connect your project to GitHub

In the RStudio Terminal:

``` bash
# Initialize git (only needed once)
git init
git add .
git commit -m "Initial commit — MC 451 Final Portfolio"

# Connect to your GitHub repo (replace with your actual URL)
git remote add origin https://github.com/YOUR-USERNAME/mc451-portfolio.git
git branch -M main
git push -u origin main
```

### Enable GitHub Pages

1.  Go to your repository on GitHub
2.  Click **Settings** (top menu) → **Pages** (left sidebar)
3.  Under **Source**, select: **Deploy from a branch**
4.  Branch: `main` \| Folder: `/docs`
5.  Click **Save**
6.  Wait 2–3 minutes, then visit: `https://YOUR-USERNAME.github.io/mc451-portfolio/`

### After making changes

Every time you edit your report:

``` bash
quarto render
git add .
git commit -m "Update: brief description of what you changed"
git push
```

GitHub Pages will update your live site within \~2 minutes of each push.

------------------------------------------------------------------------

## Updating Your Citations (`references.bib`)

### Export from Zotero (recommended)

1.  In Zotero, select all sources you want to cite
2.  **Right-click → Export Items**
3.  Format: **BibTeX**
4.  Save as `references.bib` — **replace** the existing file in this folder

### Cite in your text

| What You Type                 | What Appears                  |
|-------------------------------|-------------------------------|
| `[@Entman1993]`               | (Entman, 1993)                |
| `[@Entman1993, p. 52]`        | (Entman, 1993, p. 52)         |
| `@Entman1993`                 | Entman (1993)                 |
| `[@Entman1993; @McCombs1972]` | (Entman, 1993; McCombs, 1972) |

The citation key (e.g., `Entman1993`) is whatever appears after the `@` at the start of each entry in your `.bib` file. Zotero generates these automatically.

------------------------------------------------------------------------

## What to Submit on Blackboard

By **Friday, May 8, 2026 at 11:59 pm**, submit both:

1.  **PDF file** — located at `docs/[Your-Title].pdf` after rendering
    -   Rename it: `Lastname_FinalPortfolio.pdf`
    -   Upload this file to the Blackboard submission
2.  **Live URL** — your GitHub Pages address
    -   Format: `https://YOUR-USERNAME.github.io/mc451-portfolio/`
    -   Paste this URL directly into the Blackboard submission text box

> ⚠️ **Test your URL in a private/incognito browser window before submitting.** Confirm the site is public, all pages load, and all figures render. A broken or private link is treated the same as a missing submission.

------------------------------------------------------------------------

## Grading Criteria Quick Reference

| Section | Points | Key Requirement |
|------------------------|------------------------|------------------------|
| Introduction & Lit Review | 45 | Theory explained; RQs formally stated |
| Methodology | 50 | All elements in prose; replicable; variables defined |
| Results — Frequency Table | 25 | Embedded via R (not a screenshot); captioned |
| Results — Bar Chart | 25 | ggplot2; figure caption; narrative follows |
| Results — Chi-Square | 25 | APA format; plain-English interpretation |
| Discussion & Conclusion | 40 | RQs answered; theory connected; limitations stated |
| PDF Formatting | 20 | All sections present; professional; correct filename |
| GitHub Pages Website | 20 | Public URL; all visuals render; no broken links |
| **Total** | **250** |  |

------------------------------------------------------------------------

## Questions?

-   **Discord:** APLeith
-   **Email:** aleith\@siue.edu (allow 24 hours Mon–Fri)
-   **Office Hours:** MW 10:00–11:30 and 13:30–15:00, Dunham Hall 1017
-   **Book a meeting:** [Teams Bookings link](https://outlook.office.com/bookwithme/user/b5d8aa74215e488fbf4d85ab72761ecf@siue.edu)

------------------------------------------------------------------------

*MC 451 — Research Methods in Mass Media \| Spring 2026 \| SIUE Department of Mass Communications*

## License

The template and example materials in this repository are licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0); see `LICENSE`. The example draws on Leith, Ratan, and Wohn (2016), https://doi.org/10.1007/s10956-016-9620-x. That article is cited, not relicensed: the license covers this repository's own materials only.
