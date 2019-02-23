insert = sum(result$LST_set_Tot != 0 | result$WSQ_exe_Tot != 0 | result2$WSQ_exe_Tot != 0)
lookup = sum(result$LST_get_Tot != 0 | result$WSQ_upd_Tot != 0 | result2$WSQ_upd_Tot != 0)
delete = sum(result$LST_rmv_Tot != 0 | result2$IDB_del_Tot != 0 | result$IDB_del_Tot != 0)

IL = sum((result$LST_set_Tot != 0 & result$LST_get_Tot != 0) |
            (result$WSQ_exe_Tot != 0 & result$WSQ_upd_Tot != 0) |
            (result2$WSQ_exe_Tot != 0 & result2$WSQ_upd_Tot != 0))

ID = sum((result$LST_set_Tot != 0 & result$LST_rmv_Tot != 0) |
            (result$WSQ_exe_Tot != 0 & result$IDB_del_Tot != 0) |
            (result2$WSQ_exe_Tot != 0 & result$IDB_del_Tot != 0))

LD = sum((result$LST_get_Tot != 0 & result$LST_rmv_Tot != 0) |
            (result$WSQ_upd_Tot != 0 & result$IDB_del_Tot != 0) |
            (result2$WSQ_upd_Tot != 0 & result$IDB_del_Tot != 0))

ALL = sum((result$LST_set_Tot != 0 & result$LST_get_Tot != 0 & result$LST_rmv_Tot != 0) |
           (result$WSQ_exe_Tot != 0 & result$WSQ_upd_Tot != 0 & result2$IDB_del_Tot != 0) |
           (result2$WSQ_exe_Tot != 0 & result2$WSQ_upd_Tot != 0 & result$IDB_del_Tot != 0))

# Inject
result$INJ = ""
for (i in 1:nrow(result)) {
  if(result$LST_set_Tot[i] != 0  && result$WSQ_exe_Tot[i] != 0 && result2$WSQ_exe_Tot[i] != 0) {
    result$INJ[i] = color_LWI
  } else if(result$LST_set_Tot[i] != 0  && result$WSQ_exe_Tot[i] != 0 && result2$WSQ_exe_Tot[i] == 0) {
    result$INJ[i] = color_LW
  } else if(result$LST_set_Tot[i] != 0  && result$WSQ_exe_Tot[i] == 0 && result2$WSQ_exe_Tot[i] != 0) {
    result$INJ[i] = color_LI
  } else if(result$LST_set_Tot[i] != 0  && result$WSQ_exe_Tot[i] == 0 && result2$WSQ_exe_Tot[i] == 0) {
    result$INJ[i] = color_L
  } else if(result$LST_set_Tot[i] == 0  && result$WSQ_exe_Tot[i] != 0 && result2$WSQ_exe_Tot[i] != 0) {
    result$INJ[i] = color_WI
  } else if(result$LST_set_Tot[i] == 0  && result$WSQ_exe_Tot[i] != 0 && result2$WSQ_exe_Tot[i] == 0) {
    result$INJ[i] = color_W
  } else if(result$LST_set_Tot[i] == 0  && result$WSQ_exe_Tot[i] == 0 && result2$WSQ_exe_Tot[i] != 0) {
    result$INJ[i] = color_I
  }
}
# Lookup
result$LOK = ""
for (i in 1:nrow(result)) {
  if(result$LST_get_Tot[i] != 0  && result$WSQ_upd_Tot[i] != 0 && result2$WSQ_upd_Tot[i] != 0) {
    result$LOK[i] = color_LWI
  } else if(result$LST_get_Tot[i] != 0  && result$WSQ_upd_Tot[i] != 0 && result2$WSQ_upd_Tot[i] == 0) {
    result$LOK[i] = color_LW
  } else if(result$LST_get_Tot[i] != 0  && result$WSQ_upd_Tot[i] == 0 && result2$WSQ_upd_Tot[i] != 0) {
    result$LOK[i] = color_LI
  } else if(result$LST_get_Tot[i] != 0  && result$WSQ_upd_Tot[i] == 0 && result2$WSQ_upd_Tot[i] == 0) {
    result$LOK[i] = color_L
  } else if(result$LST_get_Tot[i] == 0  && result$WSQ_upd_Tot[i] != 0 && result2$WSQ_upd_Tot[i] != 0) {
    result$LOK[i] = color_WI
  } else if(result$LST_get_Tot[i] == 0  && result$WSQ_upd_Tot[i] != 0 && result2$WSQ_upd_Tot[i] == 0) {
    result$LOK[i] = color_W
  } else if(result$LST_get_Tot[i] == 0  && result$WSQ_upd_Tot[i] == 0 && result2$WSQ_upd_Tot[i] != 0) {
    result$LOK[i] = color_I
  }
}
# Delete
result$DLT = ""
for (i in 1:nrow(result)) {
  if(result$LST_rmv_Tot[i] != 0  && result2$IDB_del_Tot[i] != 0 && result$IDB_del_Tot[i] != 0) {
    result$DLT[i] = color_LWI
  } else if(result$LST_rmv_Tot[i] != 0  && result2$IDB_del_Tot[i] != 0 && result$IDB_del_Tot[i] == 0) {
    result$DLT[i] = color_LW
  } else if(result$LST_rmv_Tot[i] != 0  && result2$IDB_del_Tot[i] == 0 && result$IDB_del_Tot[i] != 0) {
    result$DLT[i] = color_LI
  } else if(result$LST_rmv_Tot[i] != 0  && result2$IDB_del_Tot[i] == 0 && result$IDB_del_Tot[i] == 0) {
    result$DLT[i] = color_L
  } else if(result$LST_rmv_Tot[i] == 0  && result2$IDB_del_Tot[i] != 0 && result$IDB_del_Tot[i] != 0) {
    result$DLT[i] = color_WI
  } else if(result$LST_rmv_Tot[i] == 0  && result2$IDB_del_Tot[i] != 0 && result$IDB_del_Tot[i] == 0) {
    result$DLT[i] = color_W
  } else if(result$LST_rmv_Tot[i] == 0  && result2$IDB_del_Tot[i] == 0 && result$IDB_del_Tot[i] != 0) {
    result$DLT[i] = color_I
  }
}


###########################
# BAR CHART
###########################
y = c(insert/TOT*100, lookup/TOT*100, delete/TOT*100)
x = c("Inject", "Lookup", "Delete")
d = data.frame(x, y)
ggplot(d, aes(x=x, y=y)) +
  geom_bar(stat="identity", fill="#105e62") +
  geom_text(aes(label=paste(round(y, 2), "%")), vjust=1.6, color="white", size=8) +
  labs(y = "Percentage", x="Method Type") +
  ylim(0, 100) +
  theme_minimal() + 
  scale_x_discrete(limits=x) +
  theme(text = element_text(size = 20))


###########################
# VENN
###########################
grid.newpage()
draw.triple.venn(area1 = insert,
                 area2 = lookup,
                 area3 = delete,
                 n12 = IL,
                 n13 = ID,
                 n23 = LD,
                 n123 = ALL, 
                 category = c("Inject", "Lookup", "Delete"), 
                 lty = "blank",
                 cex = rep(1.5, 7),
                 cat.cex = rep(1.75, 3),
                 print.mode = c("raw", "percent"),
                 fill = c(color_L, color_W, color_I),
                 scaled=TRUE)

###########################
# SCATTER
###########################
# Inject
site   = result$Site_Name[result$LST_set_Tot != 0 | result$WSQ_exe_Tot != 0 | result2$WSQ_exe_Tot != 0]
method = c(result$LST_set_ToS[result$INJ == color_LWI],
           result$LST_set_ToS[result$INJ == color_LW],
           result$LST_set_ToS[result$INJ == color_LI],
           result$LST_set_ToS[result$INJ == color_L],
           result$WSQ_exe_ToS[result$INJ == color_WI],
           result$WSQ_exe_ToS[result$INJ == color_W],
           result$IDB_add_ToS[result$INJ == color_I])
g = result$INJ[result$INJ != ""]
# Lookup
site   = result$Site_Name[result$LST_get_Tot != 0 | result$WSQ_upd_Tot != 0 | result2$WSQ_upd_Tot != 0]
method = c(result$LST_get_ToS[result$LOK == color_LWI],
           result$LST_get_ToS[result$LOK == color_LW],
           result$LST_get_ToS[result$LOK == color_LI],
           result$LST_get_ToS[result$LOK == color_L],
           result$WSQ_upd_ToS[result$LOK == color_WI],
           result$WSQ_upd_ToS[result$LOK == color_W],
           result$IDB_get_ToS[result$LOK == color_I])
g = result$LOK[result$LOK != ""]
# Delete
site   = result$Site_Name[result$LST_rmv_Tot != 0 | result2$IDB_del_Tot != 0 | result$IDB_del_Tot != 0]
method = c(result$LST_rmv_Tot[result$DLT == color_LWI],
           result$LST_rmv_Tot[result$DLT == color_LW],
           result$LST_rmv_Tot[result$DLT == color_LI],
           result$LST_rmv_Tot[result$DLT == color_L],
           result2$IDB_del_Tot[result$DLT == color_WI],
           result2$IDB_del_Tot[result$DLT == color_W],
           result$IDB_del_Tot[result$DLT == color_I])
g = result$DLT[result$DLT != ""]

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
       x = "Websites used method type Delete") +
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
    #round(quantile(method)[[4]], 0),
    #round(min(method), 0),
    round(max(method), 0)))

c("Var =",   round(var(method), 2),
  "Cof =",   round(sd(method)/mean(method), 2),
  "Mean =",  round(mean(method), 2),
  "Max =",   round(max(method), 0),
  "Min =",   round(min(method), 0),
  "1st Q =", round(quantile(method)[[2]], 2),
  "3rd Q =", round(quantile(method)[[4]], 2))
