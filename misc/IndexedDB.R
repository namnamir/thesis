# add() methods
# color: L
result$DD = ""
for (i in 1:nrow(result)) {
  if(result$IDB_add_Tot[i] != 0  && (result$IDB_get_Tot[i] != 0 || result$IDB_geA_Tot[i] != 0) && result$IDB_del_Tot[i] != 0) {
    result$DD[i] = color_LWI
  } else if(result$IDB_add_Tot[i] != 0  && (result$IDB_get_Tot[i] != 0 || result$IDB_geA_Tot[i] != 0) && result$IDB_del_Tot[i] == 0) {
    result$DD[i] = color_LW
  } else if(result$IDB_add_Tot[i] != 0  && (result$IDB_get_Tot[i] == 0 || result$IDB_geA_Tot[i] == 0) && result$IDB_del_Tot[i] != 0) {
    result$DD[i] = color_LI
  } else if(result$IDB_add_Tot[i] != 0  && (result$IDB_get_Tot[i] == 0 || result$IDB_geA_Tot[i] == 0) && result$IDB_del_Tot[i] == 0) {
    result$DD[i] = color_L
  }
}
# get()/getAll() methods
# color: W
result$GT = ""
for (i in 1:nrow(result)) {
  if(result$IDB_get_Tot[i] != 0  && (result$IDB_get_Tot[i] != 0 || result$IDB_geA_Tot[i] != 0) && result$IDB_del_Tot[i] != 0) {
    result$GT[i] = color_LWI
  } else if(result$IDB_add_Tot[i] != 0  && (result$IDB_get_Tot[i] != 0 || result$IDB_geA_Tot[i] != 0) && result$IDB_del_Tot[i] == 0) {
    result$GT[i] = color_LW
  } else if(result$IDB_add_Tot[i] == 0  && (result$IDB_get_Tot[i] != 0 || result$IDB_geA_Tot[i] != 0) && result$IDB_del_Tot[i] != 0) {
    result$GT[i] = color_WI
  } else if(result$IDB_add_Tot[i] == 0  && (result$IDB_get_Tot[i] != 0 || result$IDB_geA_Tot[i] != 0) && result$IDB_del_Tot[i] == 0) {
    result$GT[i] = color_W
  }
}
# delete() methods
# color: I
result$DL = ""
for (i in 1:nrow(result)) {
  if(result$IDB_add_Tot[i] != 0  && (result$IDB_get_Tot[i] != 0 || result$IDB_geA_Tot[i] != 0) && result$IDB_del_Tot[i] != 0) {
    result$DL[i] = color_LWI
  } else if(result$IDB_add_Tot[i] == 0  && (result$IDB_get_Tot[i] != 0 || result$IDB_geA_Tot[i] != 0) && result$IDB_del_Tot[i] != 0) {
    result$DL[i] = color_WI
  } else if(result$IDB_add_Tot[i] != 0  && (result$IDB_get_Tot[i] == 0 || result$IDB_geA_Tot[i] == 0) && result$IDB_del_Tot[i] != 0) {
    result$DL[i] = color_LI
  } else if(result$IDB_add_Tot[i] == 0  && (result$IDB_get_Tot[i] == 0 || result$IDB_geA_Tot[i] == 0) && result$IDB_del_Tot[i] != 0) {
    result$DL[i] = color_L
  }
}

# IndexedDB (IDB) - objectStore.add (add)
IDBaT = sum(result$IDB_add_Tot != 0)

# IndexedDB (IDB) - objectStore.get (get)
IDBgT = sum(result$IDB_get_Tot != 0 | result$IDB_geA_Tot != 0)

# IndexedDB (IDB) - objectStore.delete (del)
IDBdT = sum(result$IDB_del_Tot != 0)

ID_ALL = sum(result$IDB_add_Tot != 0  & (result$IDB_get_Tot[i] != 0 | result$IDB_geA_Tot[i] != 0) & result$IDB_del_Tot != 0)
AG     = sum(result$IDB_add_Tot != 0 & (result$IDB_get_Tot[i] != 0 | result$IDB_geA_Tot[i] != 0))
AD     = sum(result$IDB_add_Tot != 0 & result$IDB_del_Tot != 0)
GD     = sum((result$IDB_get_Tot[i] != 0 | result$IDB_geA_Tot[i] != 0) & result$IDB_del_Tot != 0)


###########################
# BAR CHART
###########################
y = c(IDBaT/I*100, IDBgT/I*100, IDBdT/I*100)
x = c("add()", "get()/getAll()", "delete()")
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
draw.triple.venn(area1 = IDBaT,
                 area2 = IDBgT,
                 area3 = IDBdT,
                 n12 = AG,
                 n23 = GD,
                 n13 = AD,
                 n123 = ID_ALL, 
                 category = c("add()", "get()", "delete()"), 
                 lty = "blank",
                 cex = rep(1.5, 7),
                 cat.cex = rep(1.75, 3),
                 print.mode = c("raw", "percent"),
                 fill = c(color_L, color_W, color_I),
                 scaled=TRUE)


###########################
# SCATTER
###########################
# add
site   = result$Site_Name[result$IDB_add_Tot != 0]
method = c(result$IDB_add_Tot[result$IDB_add_Tot != 0  & (result$IDB_get_Tot[i] != 0 | result$IDB_geA_Tot[i] != 0) & result$IDB_del_Tot != 0],
           result$IDB_add_Tot[result$IDB_add_Tot != 0  & (result$IDB_get_Tot[i] != 0 | result$IDB_geA_Tot[i] != 0) & result$IDB_del_Tot == 0],
           result$IDB_add_Tot[result$IDB_add_Tot != 0  & (result$IDB_get_Tot[i] == 0 | result$IDB_geA_Tot[i] == 0) & result$IDB_del_Tot != 0],
           result$IDB_add_Tot[result$IDB_add_Tot != 0  & (result$IDB_get_Tot[i] == 0 | result$IDB_geA_Tot[i] == 0) & result$IDB_del_Tot == 0])
g = result$DD[result$DD != ""]
# get
site   = result$Site_Name[result$IDB_get_Tot != 0]
method = result$IDB_get_Tot[result$IDB_get_Tot != 0]
g = result$GT[result$GT != ""]
# delete
site   = result$Site_Name[result$IDB_del_Tot != 0]
method = c(result$IDB_del_Tot[result$IDB_add_Tot != 0  & (result$IDB_get_Tot[i] != 0 | result$IDB_geA_Tot[i] != 0) & result$IDB_del_Tot != 0],
           result$IDB_del_Tot[result$IDB_add_Tot == 0  & (result$IDB_get_Tot[i] != 0 | result$IDB_geA_Tot[i] != 0) & result$IDB_del_Tot != 0],
           result$IDB_del_Tot[result$IDB_add_Tot != 0  & (result$IDB_get_Tot[i] == 0 | result$IDB_geA_Tot[i] == 0) & result$IDB_del_Tot != 0],
           result$IDB_del_Tot[result$IDB_add_Tot == 0  & (result$IDB_get_Tot[i] == 0 | result$IDB_geA_Tot[i] == 0) & result$IDB_del_Tot != 0])
g = result$DL[result$DL != ""]

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
       x = "Websites used delete() method") +
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
