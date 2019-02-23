# setItem() methods
# color: L
result$SI = ""
for (i in 1:nrow(result)) {
  if(result$LST_set_Tot[i] != 0  && result$LST_get_Tot[i] != 0 && result$LST_rmv_Tot[i] != 0) {
    result$SI[i] = color_LWI
  } else if(result$LST_set_Tot[i] != 0  && result$LST_get_Tot[i] != 0 && result$LST_rmv_Tot[i] == 0) {
    result$SI[i] = color_LW
  } else if(result$LST_set_Tot[i] != 0  && result$LST_get_Tot[i] == 0 && result$LST_rmv_Tot[i] != 0) {
    result$SI[i] = color_LI
  } else if(result$LST_set_Tot[i] != 0  && result$LST_get_Tot[i] == 0 && result$LST_rmv_Tot[i] == 0) {
    result$SI[i] = color_L
  }
}
# getItem() methods
# color: W
result$GI = ""
for (i in 1:nrow(result)) {
  if(result$LST_get_Tot[i] != 0  && result$LST_get_Tot[i] != 0 && result$LST_rmv_Tot[i] != 0) {
    result$GI[i] = color_LWI
  } else if(result$LST_set_Tot[i] != 0  && result$LST_get_Tot[i] != 0 && result$LST_rmv_Tot[i] == 0) {
    result$GI[i] = color_LW
  } else if(result$LST_set_Tot[i] == 0  && result$LST_get_Tot[i] != 0 && result$LST_rmv_Tot[i] != 0) {
    result$GI[i] = color_WI
  } else if(result$LST_set_Tot[i] == 0  && result$LST_get_Tot[i] != 0 && result$LST_rmv_Tot[i] == 0) {
    result$GI[i] = color_W
  }
}
# removeItem() methods
# color: I
result$RI = ""
for (i in 1:nrow(result)) {
  if(result$LST_set_Tot[i] != 0  && result$LST_get_Tot[i] != 0 && result$LST_rmv_Tot[i] != 0) {
    result$RI[i] = color_LWI
  } else if(result$LST_set_Tot[i] == 0  && result$LST_get_Tot[i] != 0 && result$LST_rmv_Tot[i] != 0) {
    result$RI[i] = color_WI
  } else if(result$LST_set_Tot[i] != 0  && result$LST_get_Tot[i] == 0 && result$LST_rmv_Tot[i] != 0) {
    result$RI[i] = color_LI
  } else if(result$LST_set_Tot[i] == 0  && result$LST_get_Tot[i] == 0 && result$LST_rmv_Tot[i] != 0) {
    result$RI[i] = color_L
  }
}

# localStorage (LST) - setItem (set)
LSTsT = sum(result$LST_set_Tot != 0)

# localStorage (LST) - getItem (get)
LSTgT = sum(result$LST_get_Tot != 0)

# localStorage (LST) - removeItem (rmv)
LSTrT = sum(result$LST_rmv_Tot != 0)

WS_ALL = sum(result$LST_set_Tot != 0  & result$LST_get_Tot != 0 & result$LST_rmv_Tot != 0)
SG     = sum(result$LST_set_Tot != 0 & result$LST_get_Tot != 0)
SR     = sum(result$LST_set_Tot != 0 & result$LST_rmv_Tot != 0)
GR     = sum(result$LST_get_Tot != 0 & result$LST_rmv_Tot != 0)


###########################
# BAR CHART
###########################
y = c(LSTsT/L*100, LSTgT/L*100, LSTrT/L*100)
x = c("setItem()", "getItem()", "removeItem()")
d = data.frame(x, y)
ggplot(d, aes(x=x, y=y)) +
  geom_bar(stat="identity", fill="#105e62") +
  geom_text(aes(label=paste(round(y, 2), "%")), vjust=1.6, color="white", size=8) +
  labs(y = "Percentage", x="Methods") +
  ylim(0, 100) +
  theme_minimal() + 
  scale_x_discrete(limits=x) +
  theme(text = element_text(size = 20))


###########################
# VENN
###########################
grid.newpage()
draw.triple.venn(area1 = LSTsT,
                 area2 = LSTgT,
                 area3 = LSTrT,
                 n12 = SG,
                 n23 = GR,
                 n13 = SR,
                 n123 = WS_ALL, 
                 category = c("setItem()", "getItem()", "removeItem()"), 
                 lty = "blank",
                 cex = rep(1.5, 7),
                 cat.cex = rep(1.75, 3),
                 print.mode = c("raw", "percent"),
                 fill = c(color_L, color_W, color_I),
                 scaled=TRUE)


###########################
# SCATTER
###########################
# setItem
site   = result$Site_Name[result$LST_set_Tot != 0]
method = c(result$LST_set_Tot[result$LST_set_Tot != 0  & result$LST_get_Tot != 0 & result$LST_rmv_Tot != 0],
           result$LST_set_Tot[result$LST_set_Tot != 0  & result$LST_get_Tot != 0 & result$LST_rmv_Tot == 0],
           result$LST_set_Tot[result$LST_set_Tot != 0  & result$LST_get_Tot == 0 & result$LST_rmv_Tot != 0],
           result$LST_set_Tot[result$LST_set_Tot != 0  & result$LST_get_Tot == 0 & result$LST_rmv_Tot == 0])
g = result$SI[result$SI != ""]
# getItem
site   = result$Site_Name[result$LST_get_Tot != 0]
method = c(result$LST_get_Tot[result$LST_set_Tot != 0  & result$LST_get_Tot != 0 & result$LST_rmv_Tot != 0],
           result$LST_get_Tot[result$LST_set_Tot != 0  & result$LST_get_Tot != 0 & result$LST_rmv_Tot == 0],
           result$LST_get_Tot[result$LST_set_Tot == 0  & result$LST_get_Tot != 0 & result$LST_rmv_Tot != 0],
           result$LST_get_Tot[result$LST_set_Tot == 0  & result$LST_get_Tot != 0 & result$LST_rmv_Tot == 0])
g = result$GI[result$GI != ""]
# removeItem
site   = result$Site_Name[result$LST_rmv_Tot != 0]
method = c(result$LST_rmv_Tot[result$LST_set_Tot != 0  & result$LST_get_Tot != 0 & result$LST_rmv_Tot != 0],
           result$LST_rmv_Tot[result$LST_set_Tot == 0  & result$LST_get_Tot != 0 & result$LST_rmv_Tot != 0],
           result$LST_rmv_Tot[result$LST_set_Tot != 0  & result$LST_get_Tot == 0 & result$LST_rmv_Tot != 0],
           result$LST_rmv_Tot[result$LST_set_Tot == 0  & result$LST_get_Tot == 0 & result$LST_rmv_Tot != 0])
g = result$RI[result$RI != ""]

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
       x = "Websites used setItem() method") +
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
    #round(min(method), 0),
    round(max(method), 0)))

c("Var =",   round(var(method), 2),
  "Cof =",   round(sd(method)/mean(method), 2),
  "Mean =",  round(mean(method), 2),
  "Max =",   round(max(method), 0),
  "Min =",   round(min(method), 0),
  "1st Q =", round(quantile(method)[[2]], 2),
  "3rd Q =", round(quantile(method)[[4]], 2))

