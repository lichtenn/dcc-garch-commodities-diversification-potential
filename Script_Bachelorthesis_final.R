Sys.setenv("LANGUAGE" = "En")
Sys.setlocale("LC_ALL", "English")

##################################################################################
#####################DATA PREPARATION##########################################
##################################################################################

# Import Daily Price Data

library("readxl")
GSCI_df <- read_excel("data/GSCI.xlsx")
GSCI_df <- GSCI_df[,c(1,5)]
GSCI_df$Date <- as.Date(GSCI_df$Date)
GSCI_df <- GSCI_df[GSCI_df$Date >= as.Date("1991-01-02") & GSCI_df$Date <= as.Date("2023-09-15"), ]
GSCI_df <- data.frame(GSCI_df)

DJCI_df <- read_excel("data/DJCI.xlsx")
DJCI_df <- DJCI_df[,c(1,5)]
DJCI_df$Date <- as.Date(DJCI_df$Date)
DJCI_df <- DJCI_df[DJCI_df$Date >= as.Date("1991-01-02") & DJCI_df$Date <= as.Date("2023-09-15"), ]
DJCI_df <- data.frame(DJCI_df)

SPGSLE_df <- read_excel("data/SPGSLE.xlsx", sheet = "SPGSLE")
SPGSLE_df <- SPGSLE_df[,c(1,5)]
SPGSLE_df$Date <- as.Date(SPGSLE_df$Date)
SPGSLE_df <- SPGSLE_df[SPGSLE_df$Date >= as.Date("1991-01-02") & SPGSLE_df$Date <= as.Date("2023-09-15"), ]
SPGSLE_df <- data.frame(SPGSLE_df)

SPGSEN_df <- read_excel("data/GSCI Subindices.xlsx", sheet = "SPGSEN")
SPGSEN_df <- SPGSEN_df[,c(1,5)]
SPGSEN_df$Date <- as.Date(SPGSEN_df$Date)
SPGSEN_df <- SPGSEN_df[SPGSEN_df$Date >= as.Date("1991-01-02") & SPGSEN_df$Date <= as.Date("2023-09-15"), ]
SPGSEN_df <- data.frame(SPGSEN_df)

SPGSLV_df <- read_excel("data/GSCI Subindices.xlsx", sheet = "SPGSLV")
SPGSLV_df <- SPGSLV_df[,c(1,5)]
SPGSLV_df$Date <- as.Date(SPGSLV_df$Date)
SPGSLV_df <- SPGSLV_df[SPGSLV_df$Date >= as.Date("1991-01-02") & SPGSLV_df$Date <= as.Date("2023-09-15"), ]
SPGSLV_df <- data.frame(SPGSLV_df)

SPGSIN_df <- read_excel("data/GSCI Subindices.xlsx", sheet = "SPGSIN")
SPGSIN_df <- SPGSIN_df[,c(1,5)]
SPGSIN_df$Date <- as.Date(SPGSIN_df$Date)
SPGSIN_df <- SPGSIN_df[SPGSIN_df$Date >= as.Date("1991-01-02") & SPGSIN_df$Date <= as.Date("2023-09-15"), ]
SPGSIN_df <- data.frame(SPGSIN_df)

SPGSPM_df <- read_excel("data/GSCI Subindices.xlsx", sheet = "SPGSPM")
SPGSPM_df <- SPGSPM_df[,c(1,5)]
SPGSPM_df$Date <- as.Date(SPGSPM_df$Date)
SPGSPM_df <- SPGSPM_df[SPGSPM_df$Date >= as.Date("1991-01-02") & SPGSPM_df$Date <= as.Date("2023-09-15"), ]
SPGSPM_df <- data.frame(SPGSPM_df)

SPGSGC_df <- read_excel("data/GSCI Subindices.xlsx", sheet = "SPGSGC")
SPGSGC_df <- SPGSGC_df[,c(1,5)]
SPGSGC_df$Date <- as.Date(SPGSGC_df$Date)
SPGSGC_df <- SPGSGC_df[SPGSGC_df$Date >= as.Date("1991-01-02") & SPGSGC_df$Date <= as.Date("2023-09-15"), ]
SPGSGC_df <- data.frame(SPGSGC_df)

SP500_df <- read_excel("data/S&P500.xlsx")
SP500_df <- SP500_df[,c(1,5)]
SP500_df$Date <- as.Date(SP500_df$Date)
SP500_df <- SP500_df[SP500_df$Date >= as.Date("1991-01-02") & SP500_df$Date <= as.Date("2023-09-15"), ]
SP500_df <- data.frame(SP500_df)

MSCI_df <- read_excel("data/MSCI World.xlsx")
MSCI_df <- MSCI_df[,c(1,5)]
MSCI_df$Date <- as.Date(MSCI_df$Date)
MSCI_df <- MSCI_df[MSCI_df$Date >= as.Date("1991-01-02") & MSCI_df$Date <= as.Date("2023-09-15"), ]
MSCI_df <- data.frame(MSCI_df)

MSCIEM_df <- read_excel("data/MSCI Emerging Markets.xlsx")
MSCIEM_df <- MSCIEM_df[,c(1,5)]
MSCIEM_df$Date <- as.Date(MSCIEM_df$Date)
MSCIEM_df <- MSCIEM_df[MSCIEM_df$Date >= as.Date("1991-01-02") & MSCIEM_df$Date <= as.Date("2023-09-15"), ]
MSCIEM_df <- data.frame(MSCIEM_df)

alldata_df <- merge(GSCI_df, DJCI_df, by = "Date", all = TRUE)
alldata_df <- merge(alldata_df, SP500_df, by = "Date", all = TRUE)
alldata_df <- merge(alldata_df, MSCI_df, by = "Date", all = TRUE)
alldata_df <- merge(alldata_df, MSCIEM_df, by = "Date", all = TRUE)
alldata_df <- merge(alldata_df, SPGSEN_df, by = "Date", all = TRUE)
alldata_df <- merge(alldata_df, SPGSGC_df, by = "Date", all = TRUE)
alldata_df <- merge(alldata_df, SPGSIN_df, by = "Date", all = TRUE)
alldata_df <- merge(alldata_df, SPGSLE_df, by = "Date", all = TRUE)
alldata_df <- merge(alldata_df, SPGSLV_df, by = "Date", all = TRUE)
alldata_df <- merge(alldata_df, SPGSPM_df, by = "Date", all = TRUE)
colnames(alldata_df) <- c("Date", "GSCI", "DJCI", "SP500", "MSCI", "MSCIEM", "SPGSEN", "SPGSGC", "SPGSIN", "SPGSLE", "SPGSLV", "SPGSPM")

# Include Daily Returns in Dataframes

library(dplyr)
stock_indices <- data.frame(alldata_df[,c(1,4,5,6)])
commodity_indices <- data.frame(alldata_df[,c(1:3,7:12)])

stock_columns <- names(stock_indices)[-which(names(stock_indices) == 'Date')]
stock_indices <- stock_indices %>%
  mutate_at(vars(stock_columns), list(Return = ~(. / lag(.)) - 1))

commodity_columns <- names(commodity_indices)[-which(names(commodity_indices) == 'Date')]
commodity_indices <- commodity_indices %>%
  mutate_at(vars(commodity_columns), list(Return = ~(. / lag(.)) - 1))

all_indices <- cbind(commodity_indices, stock_indices[,-1])

##################################################################################
#####################DESCRIPTIVE STATISTICS#######################################
##################################################################################

### Table with mean, median, maximum, minimum, standard deviation, skewness, kurtosis, number of observations, and jarque bera p-values of daily returns 
library(dplyr)
library(lubridate)
library(moments)

options(scipen = 999)

summary_stats_day <- data.frame(
  Mean = formatC(sapply(na.omit(all_indices[, c("GSCI_Return", "DJCI_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLE_Return", "SPGSLV_Return", "SPGSPM_Return", "SP500_Return", "MSCI_Return", "MSCIEM_Return")]), mean), format = "f", digits = 5),
  Median = formatC(sapply(na.omit(all_indices[, c("GSCI_Return", "DJCI_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLE_Return", "SPGSLV_Return", "SPGSPM_Return", "SP500_Return", "MSCI_Return", "MSCIEM_Return")]), median, na.rm = TRUE), format = "f", digits = 5),
  Maximum = formatC(sapply(na.omit(all_indices[, c("GSCI_Return", "DJCI_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLE_Return", "SPGSLV_Return", "SPGSPM_Return", "SP500_Return", "MSCI_Return", "MSCIEM_Return")]), max, na.rm = TRUE), format = "f", digits = 3),
  Minimum = formatC(sapply(na.omit(all_indices[, c("GSCI_Return", "DJCI_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLE_Return", "SPGSLV_Return", "SPGSPM_Return", "SP500_Return", "MSCI_Return", "MSCIEM_Return")]), min, na.rm = TRUE), format = "f", digits = 3),
  SD = formatC(sapply(na.omit(all_indices[, c("GSCI_Return", "DJCI_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLE_Return", "SPGSLV_Return", "SPGSPM_Return", "SP500_Return", "MSCI_Return", "MSCIEM_Return")]), sd, na.rm = TRUE), format = "f", digits = 4),
  Skewness = formatC(sapply(na.omit(all_indices[, c("GSCI_Return", "DJCI_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLE_Return", "SPGSLV_Return", "SPGSPM_Return", "SP500_Return", "MSCI_Return", "MSCIEM_Return")]), skewness, na.rm = TRUE), format = "f", digits = 3),
  Kurtosis = formatC(sapply(na.omit(all_indices[, c("GSCI_Return", "DJCI_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLE_Return", "SPGSLV_Return", "SPGSPM_Return", "SP500_Return", "MSCI_Return", "MSCIEM_Return")]), kurtosis, na.rm = TRUE), format = "f", digits = 3),
  Number_Observations = colSums(!is.na(all_indices[, c("GSCI", "DJCI", "SPGSEN", "SPGSGC", "SPGSIN", "SPGSLE", "SPGSLV", "SPGSPM", "SP500", "MSCI", "MSCIEM")]))
)
# Add Jarque Bera P-Values
calculate_jb_pvalue <- function(x) {
  x <- as.vector(na.omit(x))
  test_result <- jarque.test(x)
  p_value <- test_result$p.value
  return(p_value)
}
jarque_bera_pvalues <- apply(all_indices[, c("GSCI_Return", "DJCI_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLE_Return", "SPGSLV_Return", "SPGSPM_Return", "SP500_Return", "MSCI_Return", "MSCIEM_Return")], 2, calculate_jb_pvalue)
summary_stats_day$Jarque_Bera_PValue <- jarque_bera_pvalues
summary_stats_day$Jarque_Bera_PValue <- sprintf("%.4f", summary_stats_day$Jarque_Bera_PValue)

# Reorder to make number of Observations the last column
summary_stats_day <- summary_stats_day[, c("Mean", "Median", "Maximum", "Minimum", "SD", "Skewness", "Kurtosis", "Jarque_Bera_PValue", "Number_Observations")]
rownames(summary_stats_day) <- sub("_Return", "", rownames(summary_stats_day))
desired_order <- c("SP500", "MSCI", "MSCIEM", "GSCI", "DJCI", "SPGSLE", "SPGSEN", "SPGSGC", "SPGSIN", "SPGSLV", "SPGSPM")
summary_stats_day <- summary_stats_day[order(match(rownames(summary_stats_day), desired_order)), ]

# create txt document for import into Word
write.table(summary_stats_day, file = "summary_stats_day.txt", sep = ",", quote = FALSE, row.names = T)

### Simple Correlation Matrix
library(Hmisc)

corr_matr <- rcorr(as.matrix(na.omit(all_indices[, c("SP500_Return", "MSCI_Return", "MSCIEM_Return", "GSCI_Return", "SPGSLE_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLV_Return", "SPGSPM_Return")])),type = "pearson")
# Extract correlation coefficients
corr_matr$r
# Extract P-Values
corr_matr$P

# create txt document for import into Word
write.table(format(round(corr_matr$r, 3), nsmall = 3), file = "corr_matr.txt", sep = ",", quote = FALSE, row.names = T)

# I computed the correlation matrix separately for the DJCI, because the DJCI data starts later - if I used na.omit, all the data before 1999 would also not be considered for the other indices

corr_matr_DJCI <- rcorr(as.matrix(na.omit(all_indices[, c("SP500_Return", "MSCI_Return", "MSCIEM_Return", "GSCI_Return", "DJCI_Return", "SPGSLE_Return", "SPGSEN_Return", "SPGSGC_Return", "SPGSIN_Return", "SPGSLV_Return", "SPGSPM_Return")])),type = "pearson")
corr_matr_DJCI$r
corr_matr_DJCI$P

# create txt document for import into Word
write.table(format(round(corr_matr_DJCI$r, 3), nsmall = 3), file = "corr_matr_DJCI.txt", sep = ",", quote = FALSE, row.names = T)

###############################################################################
###################################DCC-GARCH MODEL#############################
###############################################################################
library("tseries")
library("rugarch")
library("FinTS")
library("e1071")
library("rmgarch")

### Check if assumptions are fulfilled
#1. Check stationarity
lapply(alldata_df[, -1], function(column) {
  adf.test(na.omit(column))
})

# Result shows that data is not stationary - I will make it stationary to estimate the GARCH model
library(dplyr)
alldata_df_stat <- alldata_df
for (col_name in names(alldata_df_stat)) {
  if (is.numeric(alldata_df_stat[[col_name]])) {
    transformed_column <- diff(log(alldata_df_stat[[col_name]]))
    alldata_df_stat[[col_name]] <- c(NA, transformed_column)
  }
}

# Check if it worked
lapply(alldata_df_stat[, -1], function(column) {
  adf.test(na.omit(column))
})

#2. Check volatility clustering
lapply(alldata_df_stat[, -1], plot.ts)


#3. Check the ARCH effect - I can only create a GARCH model if there is an ARCH effect. 
lapply(alldata_df_stat[, -1], ArchTest)
# There are ARCH effects. 

# I have checked all necessary assumptions for creating a GARCH model.

### Build the Standard GARCH model

# Check which GARCH order I have to implement
options(scipen = 999)
lapply(alldata_df_stat[, -1], function(column) {
  garch(na.omit(column), grad = "numerical", trace=FALSE)
})

# This tells me that GARCH order will be 1,1 because the result shows a1 and b1
uni_garch <- ugarchspec(variance.model = list(garchOrder=c(1,1),model="sGARCH"),mean.model = list(armaOrder=c(0,0)),distribution.model = "norm")

### Make dataframe with individual parameters
garch_fits <- lapply(names(alldata_df_stat)[-1], function(column_name) {
  column <- alldata_df_stat[[column_name]]
  column_garch_fit <- ugarchfit(uni_garch, data = na.omit(column))
})
names(garch_fits) <- names(alldata_df_stat)[-1]

SGARCH_para <- as.data.frame(garch_fits[["SP500"]]@fit$robust.matcoef)
SGARCH_para <- rbind(as.data.frame(garch_fits[["SP500"]]@fit$robust.matcoef),as.data.frame(garch_fits[["GSCI"]]@fit$robust.matcoef), as.data.frame(garch_fits[["DJCI"]]@fit$robust.matcoef),as.data.frame(garch_fits[["MSCI"]]@fit$robust.matcoef),as.data.frame(garch_fits[["MSCIEM"]]@fit$robust.matcoef),as.data.frame(garch_fits[["SPGSEN"]]@fit$robust.matcoef),as.data.frame(garch_fits[["SPGSGC"]]@fit$robust.matcoef),as.data.frame(garch_fits[["SPGSIN"]]@fit$robust.matcoef),as.data.frame(garch_fits[["SPGSLE"]]@fit$robust.matcoef),as.data.frame(garch_fits[["SPGSLV"]]@fit$robust.matcoef),as.data.frame(garch_fits[["SPGSPM"]]@fit$robust.matcoef))

new_names <- c("_SP500", "_GSCI", "_DJCI", "_MSCI", "_MSCIEM", "_SPGSEN", "_SPGSGC", "_SPGSIN", "_SPGSLE", "_SPGSLV", "_SPGSPM")
repeated_names <- rep(new_names, each = 4)
rownames(SGARCH_para) <- paste0(gsub("[0-9]", "", rownames(SGARCH_para)), repeated_names)

# create txt document for import into Word
write.table(format(round(SGARCH_para, 5), nsmall = 5), file = "SGARCH_para.txt", sep = ",", quote = FALSE, row.names = T)

### Build DCC GARCH model for S&P 500 and the other indices
# Specify model
modelspec=dccspec(uspec = multispec(replicate(2,uni_garch)),dccOrder = c(1,1), distribution = "mvnorm")

# Estimate DCC GARCH Models for the S&P 500 and the commodity indices
DCC_SP500_garch <- lapply(names(alldata_df_stat)[-c(1,4:6)], function(column_name) {
  column <- alldata_df_stat[[column_name]]
  column_DCC_garch <- dccfit(modelspec,data=na.omit(alldata_df_stat[,c("SP500",column_name)]))
})

names(DCC_SP500_garch) <- names(alldata_df_stat)[-c(1,4:6)]
DCC_SP500_garch[["GSCI"]]
GSCI_para <- as.data.frame(DCC_SP500_garch[["GSCI"]]@mfit$matcoef)[c(9,10),]
DCC_SP500_para <- rbind(as.data.frame(DCC_SP500_garch[["GSCI"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_SP500_garch[["DJCI"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_SP500_garch[["SPGSEN"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_SP500_garch[["SPGSGC"]]@mfit$matcoef)[c(9,10),], as.data.frame(DCC_SP500_garch[["SPGSIN"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_SP500_garch[["SPGSLE"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_SP500_garch[["SPGSLV"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_SP500_garch[["SPGSPM"]]@mfit$matcoef)[c(9,10),])

new_names <- c("_GSCI", "_DJCI", "_SPGSEN", "_SPGSGC", "_SPGSIN", "_SPGSLE", "_SPGSLV", "_SPGSPM")
repeated_names <- rep(new_names, each = 2)
rownames(DCC_SP500_para) <- paste0(gsub("[0-9]", "", rownames(DCC_SP500_para)), repeated_names)

# create txt document for import into Word
write.table(format(round(DCC_SP500_para, 5), nsmall = 5), file = "DCC_SP500_para.txt", sep = ",", quote = FALSE, row.names = T)

### Estimate DCC GARCH Models for the MSCI and the commodity indices

DCC_MSCI_garch <- lapply(names(alldata_df_stat)[-c(1,4:6)], function(column_name) {
  column <- alldata_df_stat[[column_name]]
  column_DCC_garch <- dccfit(modelspec,data=na.omit(alldata_df_stat[,c("MSCI",column_name)]))
})

names(DCC_MSCI_garch) <- names(alldata_df_stat)[-c(1,4:6)]
DCC_MSCI_garch[["GSCI"]]
DCC_MSCI_para <- rbind(as.data.frame(DCC_MSCI_garch[["GSCI"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCI_garch[["DJCI"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCI_garch[["SPGSEN"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCI_garch[["SPGSGC"]]@mfit$matcoef)[c(9,10),], as.data.frame(DCC_MSCI_garch[["SPGSIN"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCI_garch[["SPGSLE"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCI_garch[["SPGSLV"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCI_garch[["SPGSPM"]]@mfit$matcoef)[c(9,10),])

new_names <- c("_GSCI", "_DJCI", "_SPGSEN", "_SPGSGC", "_SPGSIN", "_SPGSLE", "_SPGSLV", "_SPGSPM")
repeated_names <- rep(new_names, each = 2)
rownames(DCC_MSCI_para) <- paste0(gsub("[0-9]", "", rownames(DCC_MSCI_para)), repeated_names)

# create txt document for import into Word
write.table(format(round(DCC_MSCI_para, 5), nsmall = 5), file = "DCC_MSCI_para.txt", sep = ",", quote = FALSE, row.names = T)

# Estimate DCC GARCH Models for the MSCIEM and the commodity indices

DCC_MSCIEM_garch <- lapply(names(alldata_df_stat)[-c(1,4:6)], function(column_name) {
  column <- alldata_df_stat[[column_name]]
  column_DCC_garch <- dccfit(modelspec,data=na.omit(alldata_df_stat[,c("MSCIEM",column_name)]))
})

names(DCC_MSCIEM_garch) <- names(alldata_df_stat)[-c(1,4:6)]
DCC_MSCIEM_para <- rbind(as.data.frame(DCC_MSCIEM_garch[["GSCI"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCIEM_garch[["DJCI"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCIEM_garch[["SPGSEN"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCIEM_garch[["SPGSGC"]]@mfit$matcoef)[c(9,10),], as.data.frame(DCC_MSCIEM_garch[["SPGSIN"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCIEM_garch[["SPGSLE"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCIEM_garch[["SPGSLV"]]@mfit$matcoef)[c(9,10),],as.data.frame(DCC_MSCIEM_garch[["SPGSPM"]]@mfit$matcoef)[c(9,10),])

new_names <- c("_GSCI", "_DJCI", "_SPGSEN", "_SPGSGC", "_SPGSIN", "_SPGSLE", "_SPGSLV", "_SPGSPM")
repeated_names <- rep(new_names, each = 2)
rownames(DCC_MSCIEM_para) <- paste0(gsub("[0-9]", "", rownames(DCC_MSCIEM_para)), repeated_names)

# create txt document for import into Word
write.table(format(round(DCC_MSCIEM_para, 5), nsmall = 5), file = "DCC_MSCIEM_para.txt", sep = ",", quote = FALSE, row.names = T)

###################################################################################
####### SP500 GSCI DCC GARCH Model Coefficient Extraction and Plotting ############
###################################################################################

# Correlation coefficient

corr_SP500_GSCI=rcor(DCC_SP500_garch[["GSCI"]])
dim(corr_SP500_GSCI)
corr_SP500_GSCI_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$SP500) & !is.na(alldata_df_stat$GSCI), 1],corr_SP500_GSCI[2,1,])
colnames(corr_SP500_GSCI_df) <- c("Date","GARCH_Corr_SP500_GSCI")
rownames(corr_SP500_GSCI_df) <- NULL

library(ggplot2)
ggplot(corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time GSCI",
       x = "Date",
       y = "Correlation Coefficient")

sub_SP500_GSCI_1 <- subset(corr_SP500_GSCI_df, Date >= "1991-01-03" & Date <= "2000-01-01")
sub_SP500_GSCI_2 <- subset(corr_SP500_GSCI_df, Date >= "2000-01-01" & Date <= "2007-01-01")
sub_SP500_GSCI_3 <- subset(corr_SP500_GSCI_df, Date >= "2007-01-01" & Date <= "2011-01-01")
sub_SP500_GSCI_4 <- subset(corr_SP500_GSCI_df, Date >= "2011-01-01" & Date <= "2020-01-01")
sub_SP500_GSCI_5 <- subset(corr_SP500_GSCI_df, Date >= "2020-01-01" & Date <= "2023-09-15")
sub_SP500_GSCI_extra <- subset(corr_SP500_GSCI_df, Date >= "2007-01-01" & Date <= "2011-01-01")
sub_SP500_GSCI_COVID <- subset(corr_SP500_GSCI_df, Date >= "2020-02-20" & Date <= "2021-01-01")
max_COVID <- sub_SP500_GSCI_COVID[which.max(sub_SP500_GSCI_COVID$GARCH_Corr_SP500_GSCI), ]
sub_SP500_GSCI_war <- subset(corr_SP500_GSCI_df, Date >= "2022-02-20" & Date <= "2023-09-15")
min_war <- sub_SP500_GSCI_war[which.min(sub_SP500_GSCI_war$GARCH_Corr_SP500_GSCI), ]
min_FC <- sub_SP500_GSCI_extra[which.min(sub_SP500_GSCI_extra$GARCH_Corr_SP500_GSCI), ]
negative_correlation_days_war <- sum(sub_SP500_GSCI_war$GARCH_Corr_SP500_GSCI < 0)


ggplot(sub_SP500_GSCI_1, aes(x = Date, y = GARCH_Corr_SP500_GSCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation over time",
       x = "Date",
       y = "Correlation Coefficient")

ggplot(sub_SP500_GSCI_2, aes(x = Date, y = GARCH_Corr_SP500_GSCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation over time ",
       x = "Date",
       y = "Correlation Coefficient")

ggplot(sub_SP500_GSCI_3, aes(x = Date, y = GARCH_Corr_SP500_GSCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation over time ",
       x = "Date",
       y = "Correlation Coefficient")

ggplot(sub_SP500_GSCI_4, aes(x = Date, y = GARCH_Corr_SP500_GSCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation over time ",
       x = "Date",
       y = "Correlation Coefficient")

ggplot(sub_SP500_GSCI_5, aes(x = Date, y = GARCH_Corr_SP500_GSCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation over time ",
       x = "Date",
       y = "Correlation Coefficient")

ggplot(sub_SP500_GSCI_war, aes(x = Date, y = GARCH_Corr_SP500_GSCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation over time",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
####### SP500 GJCI DCC GARCH Model Coefficient Extraction and Plotting ############
###################################################################################

corr_SP500_DJCI=rcor(DCC_SP500_garch[["DJCI"]])
dim(corr_SP500_DJCI)
corr_SP500_DJCI_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$SP500) & !is.na(alldata_df_stat$DJCI), 1],corr_SP500_DJCI[2,1,])
colnames(corr_SP500_DJCI_df) <- c("Date","GARCH_Corr_SP500_DJCI")
rownames(corr_SP500_DJCI_df) <- NULL

library(ggplot2)
ggplot(corr_SP500_DJCI_df, aes(x = Date, y = GARCH_Corr_SP500_DJCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.234, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
####### SP500 SPGSLE DCC GARCH Model Coefficient Extraction and Plotting ##########
###################################################################################

corr_SP500_SPGSLE=rcor(DCC_SP500_garch[["SPGSLE"]])
dim(corr_SP500_SPGSLE)
corr_SP500_SPGSLE_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$SP500) & !is.na(alldata_df_stat$SPGSLE), 1],corr_SP500_SPGSLE[2,1,])
colnames(corr_SP500_SPGSLE_df) <- c("Date","GARCH_Corr_SP500_SPGSLE")
rownames(corr_SP500_SPGSLE_df) <- NULL

library(ggplot2)
ggplot(corr_SP500_SPGSLE_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLE)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.276, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time SPGSLE",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
####### MSCI GSCI DCC GARCH Model Coefficient Extraction and Plotting #############
###################################################################################

corr_MSCI_GSCI=rcor(DCC_MSCI_garch[["GSCI"]])
dim(corr_MSCI_GSCI)
corr_MSCI_GSCI_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCI) & !is.na(alldata_df_stat$GSCI), 1],corr_MSCI_GSCI[2,1,])
colnames(corr_MSCI_GSCI_df) <- c("Date","GARCH_Corr_MSCI_GSCI")
rownames(corr_MSCI_GSCI_df) <- NULL

library(ggplot2)
ggplot(corr_MSCI_GSCI_df, aes(x = Date, y = GARCH_Corr_MSCI_GSCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.286, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time GSCI",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
####### MSCI DJCI DCC GARCH Model Coefficient Extraction and Plotting #############
###################################################################################

corr_MSCI_DJCI=rcor(DCC_MSCI_garch[["DJCI"]])
dim(corr_MSCI_DJCI)
corr_MSCI_DJCI_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCI) & !is.na(alldata_df_stat$DJCI), 1],corr_MSCI_DJCI[2,1,])
colnames(corr_MSCI_DJCI_df) <- c("Date","GARCH_Corr_MSCI_DJCI")
rownames(corr_MSCI_DJCI_df) <- NULL

library(ggplot2)
ggplot(corr_MSCI_DJCI_df, aes(x = Date, y = GARCH_Corr_MSCI_DJCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.395, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time DJCI/MSCI",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
####### MSCI SPGSLE DCC GARCH Model Coefficient Extraction and Plotting #############
###################################################################################

corr_MSCI_SPGSLE=rcor(DCC_MSCI_garch[["SPGSLE"]])
dim(corr_MSCI_SPGSLE)
corr_MSCI_SPGSLE_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCI) & !is.na(alldata_df_stat$SPGSLE), 1],corr_MSCI_SPGSLE[2,1,])
colnames(corr_MSCI_SPGSLE_df) <- c("Date","GARCH_Corr_MSCI_SPGSLE")
rownames(corr_MSCI_SPGSLE_df) <- NULL

library(ggplot2)
ggplot(corr_MSCI_SPGSLE_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSLE)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.335, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time SPGSLE/MSCI",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
####### MSCIEM GSCI DCC GARCH Model Coefficient Extraction and Plotting ###########
###################################################################################

corr_MSCIEM_GSCI=rcor(DCC_MSCIEM_garch[["GSCI"]])
dim(corr_MSCIEM_GSCI)
corr_MSCIEM_GSCI_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCIEM) & !is.na(alldata_df_stat$GSCI), 1],corr_MSCIEM_GSCI[2,1,])
colnames(corr_MSCIEM_GSCI_df) <- c("Date","GARCH_Corr_MSCIEM_GSCI")
rownames(corr_MSCIEM_GSCI_df) <- NULL

library(ggplot2)
ggplot(corr_MSCIEM_GSCI_df, aes(x = Date, y = GARCH_Corr_MSCIEM_GSCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.263, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time GSCI",
       x = "Date",
       y = "Correlation Coefficient")

negative_values <- subset(corr_MSCIEM_GSCI_df, corr_MSCIEM_GSCI_df[,2] < 0)

###################################################################################
####### MSCIEM DJCI DCC GARCH Model Coefficient Extraction and Plotting ###########
###################################################################################

corr_MSCIEM_DJCI=rcor(DCC_MSCIEM_garch[["DJCI"]])
dim(corr_MSCIEM_DJCI)
corr_MSCIEM_DJCI_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCIEM) & !is.na(alldata_df_stat$DJCI), 1],corr_MSCIEM_DJCI[2,1,])
colnames(corr_MSCIEM_DJCI_df) <- c("Date","GARCH_Corr_MSCIEM_DJCI")
rownames(corr_MSCIEM_DJCI_df) <- NULL

library(ggplot2)
ggplot(corr_MSCIEM_DJCI_df, aes(x = Date, y = GARCH_Corr_MSCIEM_DJCI)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.390, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time DJCI/MSCIEM",
       x = "Date",
       y = "Correlation Coefficient")

negative_values_MSCIEM_DJCI <- subset(corr_MSCIEM_DJCI_df, corr_MSCIEM_DJCI_df[,2]<0)

ggplot() +
  geom_line(data = corr_MSCIEM_DJCI_df, aes(x = Date, y = GARCH_Corr_MSCIEM_DJCI), color = "blue") +
  geom_line(data = corr_SP500_DJCI_df, aes(x = Date, y = GARCH_Corr_SP500_DJCI), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
####### MSCIEM SPGSLE DCC GARCH Model Coefficient Extraction and Plotting #########
###################################################################################

corr_MSCIEM_SPGSLE=rcor(DCC_MSCIEM_garch[["SPGSLE"]])
dim(corr_MSCIEM_SPGSLE)
corr_MSCIEM_SPGSLE_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCIEM) & !is.na(alldata_df_stat$SPGSLE), 1],corr_MSCIEM_SPGSLE[2,1,])
colnames(corr_MSCIEM_SPGSLE_df) <- c("Date","GARCH_Corr_MSCIEM_SPGSLE")
rownames(corr_MSCIEM_SPGSLE_df) <- NULL

library(ggplot2)
ggplot(corr_MSCIEM_SPGSLE_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSLE)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.322, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time SPGSLE/MSCIEM",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCIEM_SPGSLE_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSLE), color = "blue") +
  geom_line(data = corr_SP500_SPGSLE_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLE), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
###### SP500 Subclasses DCC GARCH Model Coefficient Extraction and Plotting #######
###################################################################################

# Correlation coefficient

corr_SP500_SPGSEN=rcor(DCC_SP500_garch[["SPGSEN"]])
corr_SP500_SPGSEN_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$SP500) & !is.na(alldata_df_stat$SPGSEN), 1],corr_SP500_SPGSEN[2,1,])
colnames(corr_SP500_SPGSEN_df) <- c("Date","GARCH_Corr_SP500_SPGSEN")
rownames(corr_SP500_SPGSEN_df) <- NULL

corr_SP500_SPGSGC=rcor(DCC_SP500_garch[["SPGSGC"]])
corr_SP500_SPGSGC_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$SP500) & !is.na(alldata_df_stat$SPGSGC), 1],corr_SP500_SPGSGC[2,1,])
colnames(corr_SP500_SPGSGC_df) <- c("Date","GARCH_Corr_SP500_SPGSGC")
rownames(corr_SP500_SPGSGC_df) <- NULL

corr_SP500_SPGSIN=rcor(DCC_SP500_garch[["SPGSIN"]])
corr_SP500_SPGSIN_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$SP500) & !is.na(alldata_df_stat$SPGSIN), 1],corr_SP500_SPGSIN[2,1,])
colnames(corr_SP500_SPGSIN_df) <- c("Date","GARCH_Corr_SP500_SPGSIN")
rownames(corr_SP500_SPGSIN_df) <- NULL

corr_SP500_SPGSLV=rcor(DCC_SP500_garch[["SPGSLV"]])
corr_SP500_SPGSLV_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$SP500) & !is.na(alldata_df_stat$SPGSLV), 1],corr_SP500_SPGSLV[2,1,])
colnames(corr_SP500_SPGSLV_df) <- c("Date","GARCH_Corr_SP500_SPGSLV")
rownames(corr_SP500_SPGSLV_df) <- NULL

corr_SP500_SPGSPM=rcor(DCC_SP500_garch[["SPGSPM"]])
corr_SP500_SPGSPM_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$SP500) & !is.na(alldata_df_stat$SPGSPM), 1],corr_SP500_SPGSPM[2,1,])
colnames(corr_SP500_SPGSPM_df) <- c("Date","GARCH_Corr_SP500_SPGSPM")
rownames(corr_SP500_SPGSPM_df) <- NULL

ggplot() +
  geom_line(data = corr_SP500_SPGSEN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSEN), color = "blue") +
  geom_line(data = corr_SP500_SPGSGC_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSGC), color = "green") +
  geom_line(data = corr_SP500_SPGSIN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSIN), color = "red") +
  geom_line(data = corr_SP500_SPGSLV_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLV), color = "purple") +
  geom_line(data = corr_SP500_SPGSPM_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSPM), color = "yellow") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

# Gold and Precious Metals move relatively in line

ggplot(corr_SP500_SPGSEN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSEN)) +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "blue") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time SPGSEN",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_SP500_SPGSEN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSEN), color = "blue") +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")


ggplot(corr_SP500_SPGSIN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSIN)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time SPGSIN",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_SP500_SPGSIN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSIN), color = "blue") +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")


ggplot(corr_SP500_SPGSLV_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLV)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.103, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time SPGSLV",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_SP500_SPGSLV_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLV), color = "blue") +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_SP500_SPGSGC_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSGC), color = "green") +
  geom_line(data = corr_SP500_SPGSPM_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSPM), color = "yellow") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time SPGSGC & SPGSPM",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_SP500_SPGSGC_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSGC), color = "blue") +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
###### MSCI Subclasses DCC GARCH Model Coefficient Extraction and Plotting ########
###################################################################################

# Correlation coefficient

corr_MSCI_SPGSEN=rcor(DCC_MSCI_garch[["SPGSEN"]])
corr_MSCI_SPGSEN_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCI) & !is.na(alldata_df_stat$SPGSEN), 1],corr_MSCI_SPGSEN[2,1,])
colnames(corr_MSCI_SPGSEN_df) <- c("Date","GARCH_Corr_MSCI_SPGSEN")
rownames(corr_MSCI_SPGSEN_df) <- NULL

corr_MSCI_SPGSGC=rcor(DCC_MSCI_garch[["SPGSGC"]])
corr_MSCI_SPGSGC_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCI) & !is.na(alldata_df_stat$SPGSGC), 1],corr_MSCI_SPGSGC[2,1,])
colnames(corr_MSCI_SPGSGC_df) <- c("Date","GARCH_Corr_MSCI_SPGSGC")
rownames(corr_MSCI_SPGSGC_df) <- NULL

corr_MSCI_SPGSIN=rcor(DCC_MSCI_garch[["SPGSIN"]])
corr_MSCI_SPGSIN_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCI) & !is.na(alldata_df_stat$SPGSIN), 1],corr_MSCI_SPGSIN[2,1,])
colnames(corr_MSCI_SPGSIN_df) <- c("Date","GARCH_Corr_MSCI_SPGSIN")
rownames(corr_MSCI_SPGSIN_df) <- NULL

corr_MSCI_SPGSLV=rcor(DCC_MSCI_garch[["SPGSLV"]])
corr_MSCI_SPGSLV_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCI) & !is.na(alldata_df_stat$SPGSLV), 1],corr_MSCI_SPGSLV[2,1,])
colnames(corr_MSCI_SPGSLV_df) <- c("Date","GARCH_Corr_MSCI_SPGSLV")
rownames(corr_MSCI_SPGSLV_df) <- NULL

corr_MSCI_SPGSPM=rcor(DCC_MSCI_garch[["SPGSPM"]])
corr_MSCI_SPGSPM_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCI) & !is.na(alldata_df_stat$SPGSPM), 1],corr_MSCI_SPGSPM[2,1,])
colnames(corr_MSCI_SPGSPM_df) <- c("Date","GARCH_Corr_MSCI_SPGSPM")
rownames(corr_MSCI_SPGSPM_df) <- NULL

ggplot() +
  geom_line(data = corr_MSCI_SPGSEN_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSEN), color = "blue") +
  geom_line(data = corr_MSCI_SPGSGC_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSGC), color = "green") +
  geom_line(data = corr_MSCI_SPGSIN_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSIN), color = "red") +
  geom_line(data = corr_MSCI_SPGSLV_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSLV), color = "purple") +
  geom_line(data = corr_MSCI_SPGSPM_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSPM), color = "yellow") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")


ggplot() +
  geom_line(data = corr_MSCI_SPGSEN_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSEN), color = "blue") +
  geom_line(data = corr_SP500_SPGSEN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSEN), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

ggplot(corr_MSCI_SPGSIN_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSIN)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time SPGSIN",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCI_SPGSIN_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSIN), color = "blue") +
  geom_line(data = corr_SP500_SPGSIN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSIN), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")


ggplot(corr_MSCI_SPGSLV_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSLV)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.103, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time SPGSLV",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCI_SPGSLV_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSLV), color = "blue") +
  geom_line(data = corr_SP500_SPGSLV_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLV), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCI_SPGSGC_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSGC), color = "green") +
  geom_line(data = corr_MSCI_SPGSPM_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSPM), color = "yellow") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time SPGSGC & SPGSPM",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCI_SPGSGC_df, aes(x = Date, y = GARCH_Corr_MSCI_SPGSGC), color = "blue") +
  geom_line(data = corr_SP500_SPGSGC_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSGC), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
###### MSCIEM Subclasses DCC GARCH Model Coefficient Extraction and Plotting ######
###################################################################################

# Correlation coefficient

corr_MSCIEM_SPGSEN=rcor(DCC_MSCIEM_garch[["SPGSEN"]])
corr_MSCIEM_SPGSEN_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCIEM) & !is.na(alldata_df_stat$SPGSEN), 1],corr_MSCIEM_SPGSEN[2,1,])
colnames(corr_MSCIEM_SPGSEN_df) <- c("Date","GARCH_Corr_MSCIEM_SPGSEN")
rownames(corr_MSCIEM_SPGSEN_df) <- NULL

corr_MSCIEM_SPGSGC=rcor(DCC_MSCIEM_garch[["SPGSGC"]])
corr_MSCIEM_SPGSGC_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCIEM) & !is.na(alldata_df_stat$SPGSGC), 1],corr_MSCIEM_SPGSGC[2,1,])
colnames(corr_MSCIEM_SPGSGC_df) <- c("Date","GARCH_Corr_MSCIEM_SPGSGC")
rownames(corr_MSCIEM_SPGSGC_df) <- NULL

corr_MSCIEM_SPGSIN=rcor(DCC_MSCIEM_garch[["SPGSIN"]])
corr_MSCIEM_SPGSIN_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCIEM) & !is.na(alldata_df_stat$SPGSIN), 1],corr_MSCIEM_SPGSIN[2,1,])
colnames(corr_MSCIEM_SPGSIN_df) <- c("Date","GARCH_Corr_MSCIEM_SPGSIN")
rownames(corr_MSCIEM_SPGSIN_df) <- NULL

corr_MSCIEM_SPGSLV=rcor(DCC_MSCIEM_garch[["SPGSLV"]])
corr_MSCIEM_SPGSLV_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCIEM) & !is.na(alldata_df_stat$SPGSLV), 1],corr_MSCIEM_SPGSLV[2,1,])
colnames(corr_MSCIEM_SPGSLV_df) <- c("Date","GARCH_Corr_MSCIEM_SPGSLV")
rownames(corr_MSCIEM_SPGSLV_df) <- NULL

adf.test(na.omit(corr_MSCIEM_SPGSLV_df$GARCH_Corr_MSCIEM_SPGSLV))
mean(corr_MSCIEM_SPGSLV_df$GARCH_Corr_MSCIEM_SPGSLV)

corr_MSCIEM_SPGSPM=rcor(DCC_MSCIEM_garch[["SPGSPM"]])
corr_MSCIEM_SPGSPM_df <- data.frame(alldata_df_stat[!is.na(alldata_df_stat$MSCIEM) & !is.na(alldata_df_stat$SPGSPM), 1],corr_MSCIEM_SPGSPM[2,1,])
colnames(corr_MSCIEM_SPGSPM_df) <- c("Date","GARCH_Corr_MSCIEM_SPGSPM")
rownames(corr_MSCIEM_SPGSPM_df) <- NULL

ggplot() +
  geom_line(data = corr_MSCIEM_SPGSEN_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSEN), color = "blue") +
  geom_line(data = corr_MSCIEM_SPGSGC_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSGC), color = "green") +
  geom_line(data = corr_MSCIEM_SPGSIN_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSIN), color = "red") +
  geom_line(data = corr_MSCIEM_SPGSLV_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSLV), color = "purple") +
  geom_line(data = corr_MSCIEM_SPGSPM_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSPM), color = "yellow") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCIEM_SPGSEN_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSEN), color = "blue") +
  geom_line(data = corr_MSCIEM_GSCI_df, aes(x = Date, y = GARCH_Corr_MSCIEM_GSCI), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

ggplot(corr_MSCIEM_SPGSIN_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSIN)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.211, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time SPGSIN",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCIEM_SPGSIN_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSIN), color = "blue") +
  geom_line(data = corr_SP500_SPGSIN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSIN), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

ggplot(corr_MSCIEM_SPGSLV_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSLV)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.103, linetype = "dashed", color = "red") +
  labs(title = "Correlation Over Time SPGSLV",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCIEM_SPGSLV_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSLV), color = "blue") +
  geom_line(data = corr_SP500_SPGSLV_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLV), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  geom_hline(yintercept = 0.0862, linetype = "solid", color = "red") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCIEM_SPGSGC_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSGC), color = "green") +
  geom_line(data = corr_MSCIEM_SPGSPM_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSPM), color = "yellow") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time SPGSGC & SPGSPM",
       x = "Date",
       y = "Correlation Coefficient")

ggplot() +
  geom_line(data = corr_MSCIEM_SPGSGC_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSGC), color = "blue") +
  geom_line(data = corr_SP500_SPGSGC_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSGC), color = "green") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "Correlation Over Time",
       x = "Date",
       y = "Correlation Coefficient")

###################################################################################
######################## Formatted Plots for the Thesis ###########################
###################################################################################

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "blue") +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = filter(corr_SP500_GSCI_df, Date >= as.Date("2007-01-01") & Date < as.Date("2009-01-01")), 
            aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "blue") +
  geom_point(data = filter(corr_SP500_GSCI_df, Date == as.Date("2008-07-09")),
             aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "green", size = 2) +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  scale_x_date(date_breaks = "2 months", date_labels = "%b %y") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(text = element_text(size = 15, family = "serif")) +
  geom_vline(xintercept = as.Date("2008-09-15"), linetype = "solid", color = "red") +
  annotate("text", x = as.Date("2008-09-15"), y = 0.4, label = "September 15, Lehman Bankruptcy", 
           color = "red", hjust = 1.05, size = 4.5, family ="serif") +
  geom_vline(xintercept = as.Date("2007-08-01"), linetype = "solid", color = "red") +
  annotate("text", x = as.Date("2007-08-01"), y = 0.4, label = "August, start of Subprime Mortgage Crisis", 
           color = "red", hjust = 1.05, size = 4.5, family ="serif") +
  annotate("text", x = as.Date("2008-07-09"), y = -0.32, label = "July 9, minimum during Subprime Mortgage Crisis", 
           color = "darkgreen", hjust = 0.5, size = 4.5, family ="serif")
  

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = filter(corr_SP500_GSCI_df, Date >= as.Date("2020-01-01") & Date < as.Date("2023-09-15")), 
            aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "blue") +
  geom_point(data = filter(corr_SP500_GSCI_df, Date == as.Date("2020-03-17")),
             aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "green", size = 2) +
  geom_point(data = filter(corr_SP500_GSCI_df, Date == as.Date("2022-03-31")),
             aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "green", size = 2) +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  scale_x_date(date_breaks = "3 months", date_labels = "%b %y") +
  scale_y_continuous(limits = c(-0.1, 0.6), breaks = seq(-0.1, 0.6, by = 0.1)) +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(text = element_text(size = 15, family = "serif")) +
  geom_vline(xintercept = as.Date("2020-02-20"), linetype = "solid", color = "red") +
  annotate("text", x = as.Date("2020-02-20"), y = 0.6, label = "February 20, start of COVID downturn", 
           color = "red", hjust = -0.05, size = 4.5, family ="serif") +
  geom_vline(xintercept = as.Date("2022-02-20"), linetype = "solid", color = "red") +
  annotate("text", x = as.Date("2022-02-24"), y = 0.6, label = "February 24, Russian invasion", 
           color = "red", hjust = -0.05, size = 4.5, family ="serif") +
  annotate("text", x = as.Date("2020-03-17"), y = 0.55, label = "March 17, maximum during COVID", 
           color = "darkgreen", hjust = -0.05, size = 4.5, family ="serif") +
  annotate("text", x = as.Date("2022-03-31"), y = -0.1, label = "March 31, minimum after invasion", 
           color = "darkgreen", hjust = -0.05, size = 4.5, family ="serif")

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = corr_SP500_SPGSEN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSEN), color = "blue") +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "green") +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = corr_MSCIEM_SPGSLV_df, aes(x = Date, y = GARCH_Corr_MSCIEM_SPGSLV), color = "blue") +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = corr_SP500_SPGSEN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSEN, color = "Blue Line")) +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI, color = "Green Line")) +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(text = element_text(size = 15, family = "serif")) +
  scale_color_manual(values = c("Blue Line" = "blue", "Green Line" = "green"),
                     labels = c("SPGSEN", "GSCI"))

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = corr_SP500_SPGSIN_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSIN, color = "Blue Line")) +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI, color = "Green Line")) +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))+
  scale_color_manual(values = c("Blue Line" = "blue", "Green Line" = "green"),
                   labels = c("SPGSIN", "GSCI"))

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = corr_SP500_SPGSLV_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLV, color = "Blue Line")) +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI, color = "Green Line")) +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))+
  scale_color_manual(values = c("Blue Line" = "blue", "Green Line" = "green"),
                     labels = c("SPGSLV", "GSCI"))

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = corr_SP500_SPGSGC_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSGC, color = "Blue Line")) +
  geom_line(data = corr_SP500_GSCI_df, aes(x = Date, y = GARCH_Corr_SP500_GSCI, color = "Green Line")) +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))+
  scale_color_manual(values = c("Blue Line" = "blue", "Green Line" = "green"),
                     labels = c("SPGSGC", "GSCI"))


ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = corr_SP500_SPGSLV_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLV, color = "Blue")) +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = corr_SP500_SPGSLV_df, aes(x = Date, y = GARCH_Corr_SP500_SPGSLV), color = "blue") +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = sub_SP500_GSCI_3, aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "blue") +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(data = sub_SP500_GSCI_5, aes(x = Date, y = GARCH_Corr_SP500_GSCI), color = "blue") +
  labs(title = "",
       x = "Date",
       y = "Correlation Coefficient",
       col = "") +
  theme_minimal()+
  theme(legend.position = "bottom")+
  theme(text=element_text(size = 15, family="serif"))

ggplot(data = all_indices) +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(aes(x = Date, y = SP500, color = "SP500")) +
  geom_line(aes(x = Date, y = MSCI, color = "MSCI")) +
  geom_line(aes(x = Date, y = MSCIEM, color = "MSCIEM")) +
  geom_line(aes(x = Date, y = GSCI, color = "GSCI")) +
  geom_line(aes(x = Date, y = DJCI, color = "DJCI")) +
  geom_line(aes(x = Date, y = SPGSLE, color = "SPGSLE")) +
  labs(title = "",
       x = "Date",
       y = "Closing Price in USD",
       col = "") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(text = element_text(size = 15, family = "serif")) +
  scale_color_manual(values = c(
    "SP500" = "black",
    "MSCI" = "red",
    "MSCIEM" = "orange",
    "GSCI" = "green",
    "DJCI" = "purple",
    "SPGSLE" = "blue"
  ),
  labels = c("SP500", "MSCI", "MSCIEM", "GSCI", "DJCI", "SPGSLE")) +
  guides(color = guide_legend(
    nrow = 2,
    byrow = TRUE,
    title.position = "top"
  ))

ggplot(data = all_indices) +
  geom_hline(yintercept = 0, linetype = "solid", color = "black", size = 0.25) +
  geom_line(aes(x = Date, y = SPGSEN, color = "SPGSEN")) +
  geom_line(aes(x = Date, y = SPGSIN, color = "SPGSIN")) +
  geom_line(aes(x = Date, y = SPGSLV, color = "SPGSLV")) +
  geom_line(aes(x = Date, y = SPGSGC, color = "SPGSGC")) +
  geom_line(aes(x = Date, y = SPGSPM, color = "SPGSPM")) +
  labs(title = "",
       x = "Date",
       y = "Closing Price in USD",
       col = "") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(text = element_text(size = 15, family = "serif")) +
  scale_color_manual(values = c(
    "SPGSEN" = "blue",
    "SPGSIN" = "red",
    "SPGSLV" = "orange",
    "SPGSGC" = "green",
    "SPGSPM" = "purple"
  ),
  labels = c("SPGSEN", "SPGSIN", "SPGSLV", "SPGSGC", "SPGSPM"))

##################################################################################
####################### Code for Further Analysis  ###############################
##################################################################################

### Code to check development for certain time frames

# Filter data for the desired date range
filtered_data <- subset(corr_SP500_GSCI_df, Date >= as.Date("2007-01-01") & Date <= as.Date("2008-12-31"))

# Check minimum and maximum
min <- filtered_data[which.min(filtered_data$GARCH_Corr_SP500_GSCI), ]
min

max <- filtered_data[which.max(filtered_data$SP500), ]
max

# Plot the filtered data
ggplot(filtered_data, aes(x = Date)) +
  geom_line(aes(y = SP500, color = "SP500")) +
  labs(title = "Index Price Development",
       x = "Date",
       y = "Price",
       col = "") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(text = element_text(size = 12, family = "serif"))