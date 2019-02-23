library(readr)
library(ggplot2)
library(splines)
library(VennDiagram)


result <- read_csv("result.csv")
result2 <- read_csv("result_OLD_Feb-2019.csv")
View(result)


color_L   = "#df0e62"  #red
color_W   = "#074684"  #blue
color_I   = "#fac70b"  #yellow
color_LI  = "#ff8b00"  #orange
color_LW  = "#5c3b6f"  #purple
color_WI  = "#3f8f8d"  #green
color_LWI = "#393e46"  #black

color_axis      = "#5c5757"  #dark grey
color_guideline = "#929aab"  #light grey
color_mean_line = "#0ea5c6"  #blue
color_coef_line = "#363333"  #grey
color_max_line  = "#8f1d14"  #red
color_min_line  = "#8f1d14"  #red
color_var_line  = "#658525"  #green
color_1q_line   = "#524c84"  #purple
color_3q_line   = "#524c84"  #purple

TOT = sum(result$Site_Name != "") # total of sites

ALL = sum(result$TotalLocalStorage != 0  & result$TotalWebSQL != 0 & result$TotalIndexedDB != 0) #all strategies together
At_Least_1 = sum(result$TotalLocalStorage != 0  | result$TotalWebSQL != 0 | result$TotalIndexedDB != 0) #Sites using at least one strategy
NONE = sum(result$TotalLocalStorage == 0  & result$TotalWebSQL == 0 & result$TotalIndexedDB == 0) #Sites using none of the strategies

L = sum(result$TotalLocalStorage != 0) #total sites using LocalStorage
W = sum(result$TotalWebSQL != 0) #total sites using WebSQL
I = sum(result$TotalIndexedDB != 0) #total sites using IndexedDB

LW = sum(result$TotalLocalStorage != 0  & result$TotalWebSQL != 0) #total sites using LocalStorage + WebSQL
LI = sum(result$TotalLocalStorage != 0  & result$TotalIndexedDB != 0) #total sites using only LocalStorage + IndexedDB
WI = sum(result$TotalWebSQL != 0 & result$TotalIndexedDB != 0) #total sites using only LocalStorage + IndexedDB


# Web Storage
result$WS = ""
for (i in 1:nrow(result)) {
  if(result$TotalLocalStorage[i] != 0  && result$TotalWebSQL[i] != 0 && result$TotalIndexedDB[i] != 0) {
    result$WS[i] = color_LWI
  } else if(result$TotalLocalStorage[i] != 0  && result$TotalWebSQL[i] != 0 && result$TotalIndexedDB[i] == 0) {
    result$WS[i] = color_LW
  } else if(result$TotalLocalStorage[i] != 0  && result$TotalWebSQL[i] == 0 && result$TotalIndexedDB[i] != 0) {
    result$WS[i] = color_LI
  } else if(result$TotalLocalStorage[i] != 0  && result$TotalWebSQL[i] == 0 && result$TotalIndexedDB[i] == 0) {
    result$WS[i] = color_L
  }
}
# WebSQL
result$WQ = ""
for (i in 1:nrow(result)) {
  if(result$TotalLocalStorage[i] != 0  && result$TotalWebSQL[i] != 0 && result$TotalIndexedDB[i] != 0) {
    result$WQ[i] = color_LWI
  } else if(result$TotalLocalStorage[i] != 0  && result$TotalWebSQL[i] != 0 && result$TotalIndexedDB[i] == 0) {
    result$WQ[i] = color_LW
  } else if(result$TotalLocalStorage[i] == 0  && result$TotalWebSQL[i] != 0 && result$TotalIndexedDB[i] != 0) {
    result$WQ[i] = color_WI
  } else if(result$TotalLocalStorage[i] == 0  && result$TotalWebSQL[i] != 0 && result$TotalIndexedDB[i] == 0) {
    result$WQ[i] = color_W
  }
}
# IndexedDB
result$ID = ""
for (i in 1:nrow(result)) {
  if(result$TotalLocalStorage[i] != 0  && result$TotalWebSQL[i] != 0 && result$TotalIndexedDB[i] != 0) {
    result$ID[i] = color_LWI
  } else if(result$TotalLocalStorage[i] == 0  && result$TotalWebSQL[i] != 0 && result$TotalIndexedDB[i] != 0) {
    result$ID[i] = color_WI
  } else if(result$TotalLocalStorage[i] != 0  && result$TotalWebSQL[i] == 0 && result$TotalIndexedDB[i] != 0) {
    result$ID[i] = color_LI
  } else if(result$TotalLocalStorage[i] == 0  && result$TotalWebSQL[i] == 0 && result$TotalIndexedDB[i] != 0) {
    result$ID[i] = color_I
  }
}


###########################
# BAR CHART
###########################
y = c(L/TOT*100, W/TOT*100, I/TOT*100)
x = c("Web Storage", "WebSQL", "IndexedDB")
d = data.frame(x, y)
ggplot(d, aes(x=x, y=y)) +
  geom_bar(stat="identity", fill="#105e62") +
  geom_text(aes(label=paste(round(y, 2), "%")), vjust=1.6, color="white", size=8) +
  labs(y = "Percentage", x="Interfaces") +
  ylim(0, 100) +
  theme_minimal() + 
  scale_x_discrete(limits=x) +
  theme(text = element_text(size = 20))


###########################
# VENN
###########################
grid.newpage()
draw.triple.venn(area1 = L,
                 area2 = W,
                 area3 = I,
                 n12 = LW,
                 n23 = WI,
                 n13 = LI,
                 n123 = ALL, 
                 category = c("Web Storage", "WebSQL", "IndexedDB"), 
                 lty = "blank",
                 cex = rep(1.5, 7),
                 cat.cex = rep(1.75, 3),
                 print.mode = c("raw", "percent"),
                 fill = c(color_L, color_W, color_I),
                 scaled=TRUE)


###########################
# SCATTER
###########################
# Web Storage
site   = result$Site_Name[result$TotalLocalStorage != 0]
method = c(result$TotalLocalStorage[result$TotalLocalStorage != 0  & result$TotalWebSQL != 0 & result$TotalIndexedDB != 0],
           result$TotalLocalStorage[result$TotalLocalStorage != 0  & result$TotalWebSQL == 0 & result$TotalIndexedDB == 0],
           result$TotalLocalStorage[result$TotalLocalStorage != 0  & result$TotalWebSQL != 0 & result$TotalIndexedDB == 0],
           result$TotalLocalStorage[result$TotalLocalStorage != 0  & result$TotalWebSQL == 0 & result$TotalIndexedDB != 0])
g = result$WS[result$WS != ""]
# WebSQL
site   = result$Site_Name[result$TotalWebSQL != 0]
method = c(result$TotalWebSQL[result$TotalLocalStorage != 0  & result$TotalWebSQL != 0 & result$TotalIndexedDB != 0],
           result$TotalWebSQL[result$TotalLocalStorage == 0  & result$TotalWebSQL != 0 & result$TotalIndexedDB == 0],
           result$TotalWebSQL[result$TotalLocalStorage != 0  & result$TotalWebSQL != 0 & result$TotalIndexedDB == 0],
           result$TotalWebSQL[result$TotalLocalStorage == 0  & result$TotalWebSQL != 0 & result$TotalIndexedDB != 0])
g = result$WQ[result$WQ != ""]
# IndexedDB
site   = result$Site_Name[result$TotalIndexedDB != 0]
method = c(result$TotalIndexedDB[result$TotalLocalStorage != 0  & result$TotalWebSQL != 0 & result$TotalIndexedDB != 0],
           result$TotalIndexedDB[result$TotalLocalStorage == 0  & result$TotalWebSQL == 0 & result$TotalIndexedDB != 0],
           result$TotalIndexedDB[result$TotalLocalStorage != 0  & result$TotalWebSQL == 0 & result$TotalIndexedDB != 0],
           result$TotalIndexedDB[result$TotalLocalStorage == 0  & result$TotalWebSQL != 0 & result$TotalIndexedDB != 0])
g = result$ID[result$ID != ""]

data   = data.frame("y"=site, "x"=method)

ggplot(aes(x=site, y=method), data=data) +
  theme(plot.background  = element_rect(fill="transparent"),
        panel.background = element_rect(fill="transparent"),
        #panel.grid.major = element_line(colour=color_guideline, size=0.5),
        #panel.grid.minor = element_line(colour="color_guideline, size=0.5),
        axis.line        = element_line(colour=color_axis, size=1),
        axis.text.x      = element_blank(),
        plot.title = element_text(hjust = 0.5)) +
  labs(title = NULL, subtitle = NULL, colour = NULL,  shape = NULL, 
       y = "Number of occurerence in a single website",
       x = "Websites used WebSQL") +
  geom_point(group=g, colour=g, size = 1.0, alpha=0.7) +
  geom_hline(aes(yintercept = mean(method),            colour="Mean"), size=0.5, alpha=0.7,  show.legend=TRUE) +
  #geom_hline(aes(yintercept = var(method),             colour="Variance"), size=0.5, alpha=0.7) +
  geom_hline(aes(yintercept = max(method),             colour="Maximum"), size=0.5, alpha=0.7) +
  geom_hline(aes(yintercept = min(method),             colour="Minimum"), size=0.5, alpha=0.7) +  
  #geom_hline(aes(yintercept = sd(method)/mean(method), colour="Coefficient"), size=0.5, alpha=0.7) +
  geom_hline(aes(yintercept = quantile(method)[[2]],   colour="1st Quantile"), size=0.5, alpha=0.7) +
  geom_hline(aes(yintercept = quantile(method)[[4]],   colour="3rd Quantile"), size=0.5, alpha=0.7) +
  scale_colour_manual(values = c(color_1q_line, color_3q_line, color_max_line, color_mean_line, color_min_line)) +
  scale_y_continuous(breaks = c(#round(var(method), 2),
    #round(sd(method)/mean(method), 2),
    round(mean(method), 2),
    round(quantile(method)[[2]], 0),
    round(quantile(method)[[4]], 0),
    round(min(method), 0),
    round(max(method), 0)))

c("Var =",   round(var(method), 2),
  "Cof =",   round(sd(method)/mean(method), 2),
  "Mean =",  round(mean(method), 2),
  "Max =",   round(max(method), 0),
  "Min =",   round(min(method), 0),
  "1st Q =", round(quantile(method)[[2]], 2),
  "3rd Q =", round(quantile(method)[[4]], 2))
