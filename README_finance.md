# 💰 Financial Operations & Campaign Performance Analysis
### Bank Marketing Dataset | 41,188 Customer Records | Python · SQL · Excel · Power BI

---

## 📌 Project Overview

A Portuguese bank ran a series of direct phone marketing campaigns to sell term deposit subscriptions. Despite high call volumes, the **overall conversion rate was just 11.27%** — meaning 88%+ of outreach effort was producing no return.

This project performs a full **financial operations and campaign performance analysis** to answer:
- *Which customer segments convert and which are money pits?*
- *After how many calls does outreach become wasteful?*
- *Which months and contact methods maximise ROI?*
- *Where are the statistical anomalies draining campaign budget?*

---

## 📂 Project Structure

```
Finance-Analytics-Project/
│
├── Finance_analysis_1.ipynb       # KPI analysis — conversion, campaign, age, monthly
├── Finance_analysis_2.ipynb       # Segment deep-dive, anomaly detection, Power BI export
│
├── bank-additional-full.csv       # Raw dataset (41,188 records, 20+ features)
├── sql.sql                        # SQL queries — segmentation, KPIs, executive summary
│
├── bank_analytics.db              # SQLite database for SQL analysis
│
└── outputs/
    ├── chart_01_conversion_by_job.png
    ├── chart_02_campaign_efficiency.png
    ├── chart_03_monthly_performance.png
    ├── chart_04_age_band.png
    ├── chart_05_job_education_heatmap.png
    ├── chart_06_age_poutcome.png
    ├── chart_07_contact_month.png
    ├── chart_08_duration_anomaly.png
    ├── chart_09_underperformers.png
    ├── bank_financial_model.xlsx    # Excel financial model with KPI tables
    └── Finance.db                   # Cleaned SQLite DB
```

---

## 📊 Dataset

| Attribute | Detail |
|---|---|
| **Source** | UCI ML Repository — Bank Marketing Dataset |
| **Records** | 41,188 customer contacts |
| **Features** | 20 attributes (demographics, campaign details, economic indicators) |
| **Target** | `y` — whether the customer subscribed to a term deposit (yes/no) |
| **Tool** | 'unknown' string used as missing value placeholder → treated as NaN |

---

## 🔧 Methodology

### Phase 1 — Data Cleaning
- Replaced `'unknown'` string values with `NaN` across all categorical columns
- Created binary `subscribed` target column (`1` = yes, `0` = no)
- Exported cleaned dataset as `bank_customers_clean.csv` for downstream analysis

### Phase 2 — KPI Analysis (Python)

| KPI | Description |
|---|---|
| Overall conversion rate | % of all contacts who subscribed |
| Conversion by job segment | Which professions respond best to campaigns |
| Campaign efficiency curve | Conversion rate vs number of calls made |
| Monthly performance | Contacts and success rate by calendar month |
| Age band analysis | Subscription likelihood across 6 age groups |

### Phase 3 — Segment Analysis (Python)

- **Job × Education heatmap** — cross-tabulated conversion rates to find highest-value customer segments
- **Previous outcome × Age band** — customers with prior successful contact analysed by age group
- **Contact method × Month** — cellular vs telephone efficiency across all 12 months
- **Top 10 highest-converting segments** — filtered for volume (100+ contacts), ranked by conversion rate

### Phase 4 — Anomaly Detection (Python + Z-Score)

| Anomaly | Method |
|---|---|
| Over-contacted customers | Z-score > 3.0 on `campaign` column |
| Long calls with no conversion | Top 5% duration + `subscribed == 0` |
| High-volume / low-conversion segments | Above-median contacts + below-median conversion rate |

### Phase 5 — SQL Analysis (SQLite)

12 structured SQL queries covering:
- Customer base overview (age distribution, segment sizes)
- Conversion KPIs by job, education, and age band
- Monthly subscription success rates
- Previous campaign outcome impact
- Executive summary: top-converting job × education combinations

### Phase 6 — Excel Financial Model & Power BI Export
- Pre-aggregated tables exported specifically for Power BI dashboard consumption
- Excel model (`bank_financial_model.xlsx`) with KPI summary, segment performance, and campaign efficiency data

---

## 📈 Key Findings

| # | Finding |
|---|---|
| 1 | **Overall conversion rate: 11.27%** — 88%+ of campaign effort yielded no subscription |
| 2 | **65+ age group converts at 47.2%** — highest of any age band, vs 11.27% overall |
| 3 | **Calls beyond 3 show sharply diminishing returns** — campaign efficiency drops steeply after the 3rd contact |
| 4 | **869 over-contacted customers** (Z-score flagged) accounted for Rs. 1.3L in wasted campaign spend |
| 5 | **Retired and student segments** show disproportionately high conversion rates vs blue-collar workers |
| 6 | **May has the highest call volume but low success rate** — October and March show the best conversion efficiency |
| 7 | **Cellular contact outperforms telephone** across almost every month |
| 8 | **Prior successful campaign contact** dramatically improves conversion — `poutcome = success` customers convert at ~65% |

---

## 📉 Charts Generated (9 total)

| Chart | Description |
|---|---|
| `chart_01_conversion_by_job.png` | Bar chart — conversion rate by job segment |
| `chart_02_campaign_efficiency.png` | Line chart — conversion drop-off as calls increase |
| `chart_03_monthly_performance.png` | Dual-axis — contacts volume + success rate by month |
| `chart_04_age_band.png` | Bar chart — conversion rate across 6 age bands |
| `chart_05_job_education_heatmap.png` | Heatmap — conversion by job × education cross-segment |
| `chart_06_age_poutcome.png` | Line chart — previous outcome effect by age group |
| `chart_07_contact_month.png` | Line chart — cellular vs telephone efficiency by month |
| `chart_08_duration_anomaly.png` | Histogram — call duration distribution (converted vs not) |
| `chart_09_underperformers.png` | Bar chart — high-volume, low-conversion "money pit" segments |

---

## 🚀 How to Run

### Prerequisites

```bash
pip install pandas matplotlib seaborn openpyxl scipy
```

### Run the Notebooks

```bash
# Clone the repository
git clone https://github.com/your-username/finance-analytics-project.git
cd finance-analytics-project

# Launch Jupyter
jupyter notebook Finance_analysis_1.ipynb   # KPI analysis
jupyter notebook Finance_analysis_2.ipynb   # Segments + anomaly detection
```

### Run SQL Queries

Open `sql.sql` in DB Browser for SQLite or any SQLite client, connected to `bank_analytics.db`.

---

## 🛠 Tech Stack

| Tool | Purpose |
|---|---|
| Python 3.10 | Data processing, KPI calculation, anomaly detection |
| Pandas / NumPy | Data cleaning and transformation |
| Matplotlib / Seaborn | Chart generation (9 charts) |
| SciPy | Z-score anomaly detection |
| SQL (SQLite) | Segmentation queries and executive summary |
| Excel | Financial model and KPI summary tables |
| Power BI | Interactive dashboard (pre-aggregated data export) |
| Jupyter | Interactive analysis notebooks |

---

## 📜 Data Source

Moro, S., Cortez, P., & Rita, P. (2014). *A Data-Driven Approach to Predict the Success of Bank Telemarketing.* Decision Support Systems.

Dataset: [UCI ML Repository — Bank Marketing](https://archive.ics.uci.edu/dataset/222/bank+marketing)
