# Diversification, Hedging & Safe Haven Potential of Commodities
### A DCC-GARCH Analysis of Commodity-Equity Correlations (1992–2023)

Bachelor's thesis evaluating whether commodities serve as effective 
diversifiers, hedges, or safe havens for equity portfolios. Using 
Dynamic Conditional Correlation (DCC-GARCH) modelling, the time-varying 
correlation between the S&P GSCI composite index and its subindices 
with the S&P 500 is analysed across three major market crises: the 
Global Financial Crisis (GFC), the COVID-19 Market Crash, and the 
Russian invasion of Ukraine.

As one of the first works to examine commodity-equity correlations 
during the COVID Market Crash and the Russian invasion, this thesis 
contributes to an underexplored area of the existing literature.

## Research question

Are commodities — at the composite index and subindex level — 
effective diversifiers, hedges, or safe havens for stock portfolios, 
and how has this potential evolved between 1992 and 2023?

## Theoretical framework

Assets are classified following the widely adopted definitions of 
Baur & Lucey (2010):

| Classification | Definition |
|----------------|-----------|
| **Diversifier** | Positively but not perfectly correlated with the portfolio on average |
| **Hedge** | Uncorrelated or negatively correlated with the portfolio on average |
| **Safe haven** | Uncorrelated or negatively correlated with the portfolio specifically during market stress |

## Methodology

- **Model**: DCC-GARCH (Dynamic Conditional Correlation — 
  Generalised Autoregressive Conditional Heteroskedasticity)
- **Assets**: S&P GSCI composite index and subindices (energy, 
  industrial metals, precious metals, gold, livestock) vs. S&P 500
- **Period**: 1992–2023
- **Crisis periods analysed**:
  - Global Financial Crisis (GFC), 2008
  - COVID-19 Market Crash, 2020
  - Russian invasion of Ukraine, 2022
- **Robustness checks** included

## Key findings

**Composite commodity index (GSCI)**
- Neither an effective hedge nor a safe haven for major market 
  downturns
- Qualifies as a diversifier, though the average correlation of 
  0.329 with the S&P 500 raises questions about the practical value 
  of this classification
- Acted as a safe haven during minor but not major crises — 
  demonstrating that crisis severity influences safe haven adequacy

**Impact of financialization**
- The GFC, in connection with financialization, caused a permanent 
  structural shift in commodity-equity correlations toward positive 
  territory
- Prior to 2008: commodities were close to zero correlation — 
  viable hedges
- After 2008: correlation shifted significantly positive — 
  only viable as diversifiers
- During the Subprime phase of the GFC: negative correlation 
  (safe haven); as the crisis became global in nature: 
  correlation turned positive

**Crisis-specific behaviour**
- COVID-19: further increase of the already positive correlation
- Russian invasion of Ukraine: correlation declined to slightly 
  negative — attributed to Russia's role as a major commodity 
  exporter, or interpreted as another example of crisis-severity- 
  dependent safe haven behaviour

**Commodity subindices**
| Subindex | Classification |
|----------|---------------|
| Energy (SPGSEN) | Diversifier |
| Industrial Metals (SPGSIN) | Diversifier |
| Livestock (SPGSLV) | Diversifier |
| Precious Metals | Hedge & Safe Haven |
| Gold | Hedge & Safe Haven |

## Repository structure

| File | Contents |
|------|----------|
| `Bachelorthesis_final.pdf` | Bachelorthesis |
| `Script_Bachelorthesis_final.R` | Script with full analysis: data preparation, DCC-GARCH modelling, correlation analysis, crisis event analysis, subindex assessment, robustness checks |
| `data/` | Data |

> Note: the DCC-GARCH model was implemented in R using the 
> `rugarch` and `rmgarch` packages. The R script is included 
> alongside the analysis notebook.

## Reference
Baur, D. G., & Lucey, B. M. (2010). Is gold a hedge or a safe 
haven? An analysis of stocks, bonds and gold. *The Financial 
Review*, 45(2), 217–229.
