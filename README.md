# CI/CD demo: save a change, it gets checked, it goes live

A tiny website with an automated pipeline. Every time the code changes, GitHub
builds the site, inspects it, and publishes it only if the inspection passes.
Setup takes about 15 minutes.

## The one-sentence version

> CI/CD is an automated assembly line for software: every change is checked by
> a robot, and only changes that pass are published to customers.

- **CI (Continuous Integration)** is the quality inspector. Every change is built and tested automatically.
- **CD (Continuous Deployment)** is the delivery truck. Approved changes go live with nobody pressing a button.

A useful picture for a non-technical audience is a **newspaper**: a writer hands
in an article, the proofreader checks it, and the printing press publishes it.
A failed proofread means nothing gets printed, and yesterday's edition stays on
the stands.

## What is in this folder

| File | What it is | Newspaper equivalent |
|---|---|---|
| `site/index.html`, `site/style.css` | The website | The article |
| `build.sh` | Assembles the site and stamps it with a release number | Typesetting the page |
| `tests/check.sh` | Six automatic quality checks | The proofreader |
| `.github/workflows/pipeline.yml` | The instructions GitHub follows | The newsroom's standing rules |

## Setup

You need a GitHub account and `git` on your computer.

### 1. Create the repository (2 min)

Go to <https://github.com/new>. Name it `cicd-demo`, set it to **Public**, leave
every checkbox empty, and click **Create repository**.

*What this is:* a repository is a shared folder that remembers every change
ever made, who made it, and when.

### 2. Switch on publishing (1 min)

In the new repository: **Settings → Pages → Build and deployment → Source →
GitHub Actions**.

*What this is:* telling GitHub "my pipeline is allowed to publish a website
from this project."

### 3. Push the project (3 min)

From inside this folder:

```bash
git init -b main
git add .
git commit -m "First release"
git remote add origin https://github.com/YOUR-USERNAME/cicd-demo.git
git push -u origin main
```

*What this is:* handing the article to the newsroom. This push is the only
manual act. Everything after it is automatic.

### 4. Watch the pipeline run (2 min)

Open the **Actions** tab. You will see one run with two boxes joined by a line:
**Build and check**, then **Publish to the live site**. Click the first box to
see the six checks print `PASS`.

*What this is:* GitHub rented a brand-new computer, downloaded the code,
built the site, inspected it, published it, and threw the computer away.

### 5. Open the live site (1 min)

`https://YOUR-USERNAME.github.io/cicd-demo/`

The page shows **Release #1**, a change ID, and the time it was published.

### 6. Make a change (3 min)

On GitHub, open `site/index.html`, click the pencil icon, change the text
between `<h1>` and `</h1>`, and click **Commit changes**. Watch the Actions
tab, then refresh the site. It now says **Release #2** with your new headline.

*What this is:* the whole point. One saved edit became a live release in about
a minute, and it was checked on the way.

### 7. Break it on purpose (3 min)

Edit the same line and make the headline `TODO`. Commit. In the Actions tab
the first box turns red and the second box never runs. Refresh the site: it
still shows Release #2, untouched.

Change the headline back to something real and commit. The pipeline goes
green and Release #4 goes live. (The failed attempt used up #3.)

*What this is:* the safety net. A mistake was caught by the robot, not by a
customer.

## Run it on your own computer

```bash
bash build.sh
bash tests/check.sh dist
```
