# INSERT
# color: L
result$IN = ""
for (i in 1:nrow(result)) {
  if(result$WSQ_exe_Tot[i] != 0  && result$WSQ_upd_Tot[i] != 0 && result$WSQ_del_Tot[i] != 0) {
    result$IN[i] = color_LWI
  } else if(result$WSQ_exe_Tot[i] != 0  && result$WSQ_upd_Tot[i] != 0 && result$WSQ_del_Tot[i] == 0) {
    result$IN[i] = color_LW
  } else if(result$WSQ_exe_Tot[i] != 0  && result$WSQ_upd_Tot[i] == 0 && result$WSQ_del_Tot[i] != 0) {
    result$IN[i] = color_LI
  } else if(result$WSQ_exe_Tot[i] != 0  && result$WSQ_upd_Tot[i] == 0 && result$WSQ_del_Tot[i] == 0) {
    result$IN[i] = color_L
  }
}
# UPDATE
# color: W
result$UP = ""
for (i in 1:nrow(result)) {
  if(result$WSQ_upd_Tot[i] != 0  && result$WSQ_upd_Tot[i] != 0 && result$WSQ_del_Tot[i] != 0) {
    result$UP[i] = color_LWI
  } else if(result$WSQ_exe_Tot[i] != 0  && result$WSQ_upd_Tot[i] != 0 && result$WSQ_del_Tot[i] == 0) {
    result$UP[i] = color_LW
  } else if(result$WSQ_exe_Tot[i] == 0  && result$WSQ_upd_Tot[i] != 0 && result$WSQ_del_Tot[i] != 0) {
    result$UP[i] = color_WI
  } else if(result$WSQ_exe_Tot[i] == 0  && result$WSQ_upd_Tot[i] != 0 && result$WSQ_del_Tot[i] == 0) {
    result$UP[i] = color_W
  }
}
# DELETE
# color: I
result$DE = ""
for (i in 1:nrow(result)) {
  if(result$WSQ_exe_Tot[i] != 0  && result$WSQ_upd_Tot[i] != 0 && result$WSQ_del_Tot[i] != 0) {
    result$DE[i] = color_LWI
  } else if(result$WSQ_exe_Tot[i] == 0  && result$WSQ_upd_Tot[i] != 0 && result$WSQ_del_Tot[i] != 0) {
    result$DE[i] = color_WI
  } else if(result$WSQ_exe_Tot[i] != 0  && result$WSQ_upd_Tot[i] == 0 && result$WSQ_del_Tot[i] != 0) {
    result$DE[i] = color_LI
  } else if(result$WSQ_exe_Tot[i] == 0  && result$WSQ_upd_Tot[i] == 0 && result$WSQ_del_Tot[i] != 0) {
    result$DE[i] = color_L
  }
}

# WebSQL (WSQ) - executeSql.INSERT (exe)
WSQeT = sum(result$WSQ_exe_Tot != 0)

# WebSQL (WSQ) - executeSql.UPDATE (upd)

WSQuT = sum(result$WSQ_upd_Tot != 0)

# WebSQL (WSQ) - executeSql.DELETE (del)
WSQdT = sum(result$WSQ_del_Tot != 0)

WQ_ALL = sum(result$WSQ_exe_Tot != 0  & result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot != 0)
EU     = sum(result$WSQ_exe_Tot != 0 & result$WSQ_upd_Tot != 0)
ED     = sum(result$WSQ_exe_Tot != 0 & result$WSQ_del_Tot != 0)
UD     = sum(result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot != 0)


###########################
# BAR CHART
###########################
y = c(WSQeT/W*100, WSQuT/W*100, WSQdT/W*100)
x = c("INSERT INTO", "UPDATE", "DELETE FROM")
d = data.frame(x, y)
ggplot(d, aes(x=x, y=y)) +
  geom_bar(stat="identity", fill="#105e62") +
  geom_text(aes(label=paste(round(y, 2), "%")), vjust=1.6, color="white", size=8) +
  labs(y = "Percentage", x="Queries") +
  ylim(0, 100) +
  theme_minimal() + 
  scale_x_discrete(limits=x) +
  theme(text = element_text(size = 20))


###########################
# VENN
###########################
grid.newpage()
draw.triple.venn(area1 = WSQeT,
                 area2 = WSQuT,
                 area3 = WSQdT,
                 n12 = EU,
                 n23 = UD,
                 n13 = ED,
                 n123 = WQ_ALL, 
                 category = c("INSERT", "UPDATE", "DELETE"), 
                 lty = "blank",
                 cex = rep(1.5, 7),
                 cat.cex = rep(1.75, 3),
                 print.mode = c("raw", "percent"),
                 fill = c(color_L, color_W, color_I),
                 scaled=TRUE)


###########################
# SCATTER
###########################
# INSERT INTO
site   = result$Site_Name[result$WSQ_exe_Tot != 0]
method = c(result$WSQ_exe_Tot[result$WSQ_exe_Tot != 0  & result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot != 0],
           result$WSQ_exe_Tot[result$WSQ_exe_Tot != 0  & result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot == 0],
           result$WSQ_exe_Tot[result$WSQ_exe_Tot != 0  & result$WSQ_upd_Tot == 0 & result$WSQ_del_Tot != 0],
           result$WSQ_exe_Tot[result$WSQ_exe_Tot != 0  & result$WSQ_upd_Tot == 0 & result$WSQ_del_Tot == 0])
g = result$IN[result$IN != ""]
# UPDATE
site   = result$Site_Name[result$WSQ_upd_Tot != 0]
method = c(result$WSQ_upd_Tot[result$WSQ_exe_Tot != 0  & result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot != 0],
           result$WSQ_upd_Tot[result$WSQ_exe_Tot != 0  & result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot == 0],
           result$WSQ_upd_Tot[result$WSQ_exe_Tot == 0  & result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot != 0],
           result$WSQ_upd_Tot[result$WSQ_exe_Tot == 0  & result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot == 0])
g = result$UP[result$UP != ""]
# DELETE FROM
site   = result$Site_Name[result$WSQ_del_Tot != 0]
method = c(result$WSQ_del_Tot[result$WSQ_exe_Tot != 0  & result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot != 0],
           result$WSQ_del_Tot[result$WSQ_exe_Tot == 0  & result$WSQ_upd_Tot != 0 & result$WSQ_del_Tot != 0],
           result$WSQ_del_Tot[result$WSQ_exe_Tot != 0  & result$WSQ_upd_Tot == 0 & result$WSQ_del_Tot != 0],
           result$WSQ_del_Tot[result$WSQ_exe_Tot == 0  & result$WSQ_upd_Tot == 0 & result$WSQ_del_Tot != 0])
g = result$DE[result$DE != ""]

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
       x = "Websites used UPDATE query") +
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
