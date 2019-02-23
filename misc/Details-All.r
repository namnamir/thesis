setwd("C:\\Users\\ali\\Desktop\\R\\G")
data<-read.csv('indexed_db_bulk.csv' , sep=",", header=TRUE)
nam <- data[["Type"]]
mem <- data[["Memory_Usage"]]
cpu <- data[["CPU_Load"]]
bat <- data[["Battery_Power"]] #in microwatt
tim <- data[["Time"]] #in milisecond
# Energy = Battery (in Watt) x Time (in hour)
batw <- bat / 1000000 #battery in watt
timh <- tim / 3600000 #time in hour
eng <- batw * timh
row <- data[["Row"]]

library(ggplot2)
library(splines)

############ ############ ############
############ CPU - ROW
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-CPU0.png", 1000, 700)
qplot(row, cpu, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
  ) +
  geom_hline(
    yintercept = mean(cpu), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(cpu), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(cpu), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(cpu), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(cpu), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "CPU Consumption (%)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-CPU1.png", 1000, 700)
qplot(row, cpu, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
  ) +
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "CPU Consumption (%)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-CPU2.png", 1000, 700)
qplot(row, cpu, data=data
  ) +
  geom_hline(
    yintercept = mean(cpu), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(cpu), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(cpu), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(cpu), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(cpu), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "CPU Consumption (%)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-CPU3.png", 1000, 700)
qplot(row, cpu, data=data
  ) +
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "CPU Consumption (%)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
############ ############ ############

############ ############ ############
############ Memory - ROW
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Memory0.png", 1000, 700)
qplot(row, mem, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
  ) +
  geom_hline(
    yintercept = mean(mem), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(mem), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(mem), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(mem), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(mem), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Memory Consumption (KB)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Memory1.png", 1000, 700)
qplot(row, mem, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Memory Consumption (KB)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Memory2.png", 1000, 700)
qplot(row, mem, data=data
  ) +
  geom_hline(
    yintercept = mean(mem), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(mem), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(mem), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(mem), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(mem), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Memory Consumption (KB)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Memory3.png", 1000, 700)
qplot(row, mem, data=data
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Memory Consumption (KB)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
############ ############ ############


############ ############ ############
############ Power - ROW
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power0.png", 1000, 700)
qplot(row, bat, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
) +
  geom_hline(
    yintercept = mean(bat), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(bat), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(bat), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Power Consumption (uW)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power1.png", 1000, 700)
qplot(row, bat, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
) +
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Power Consumption (uW)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power2.png", 1000, 700)
qplot(row, bat, data=data
) +
  geom_hline(
    yintercept = mean(bat), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(bat), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(bat), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Power Consumption (uW)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power3.png", 1000, 700)
qplot(row, bat, data=data
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Power Consumption (uW)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
############ ############ ############


############ ############ ############
############ Power - CPU
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power-CPU0.png", 1000, 700)
qplot(bat, cpu, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
) +
  geom_vline(
    xintercept = mean(bat), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_vline(
    xintercept = median(bat), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_vline(
  #  xintercept = var(bat), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_vline(
    xintercept = max(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_vline(
    xintercept = min(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  geom_hline(
    yintercept = mean(cpu), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(cpu), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(cpu), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(cpu), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(cpu), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       x = "Power Consumption (uW)",
       y = "CPU Consumption (%)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power-CPU1.png", 1000, 700)
qplot(bat, cpu, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
) +
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       x = "Power Consumption (uW)",
       y = "CPU Consumption (%)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power-CPU2.png", 1000, 700)
qplot(bat, cpu, data=data,
) +
  geom_vline(
    xintercept = mean(bat), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_vline(
    xintercept = median(bat), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_vline(
  #  xintercept = var(bat), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_vline(
    xintercept = max(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_vline(
    xintercept = min(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  geom_hline(
    yintercept = mean(cpu), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(cpu), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(cpu), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(cpu), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(cpu), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       x = "Power Consumption (uW)",
       y = "CPU Consumption (%)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power-CPU3.png", 1000, 700)
qplot(bat, cpu, data=data,
) + 
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       x = "Power Consumption (uW)",
       y = "CPU Consumption (%)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
############ ############ ############


############ ############ ############
############ Power - Memory
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power-Memory0.png", 1000, 700)
qplot(bat, mem, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
) +
  geom_vline(
    xintercept = mean(bat), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_vline(
    xintercept = median(bat), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_vline(
  #  xintercept = var(bat), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_vline(
    xintercept = max(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_vline(
    xintercept = min(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  geom_hline(
    yintercept = mean(mem), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(mem), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(mem), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(mem), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(mem), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       x = "Power Consumption (uW)",
       y = "Memory Consumption (KB)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power-Memory1.png", 1000, 700)
qplot(bat, mem, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
) +
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       x = "Power Consumption (uW)",
       y = "Memory Consumption (KB)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power-Memory2.png", 1000, 700)
qplot(bat, mem, data=data,
) +
  geom_vline(
    xintercept = mean(bat), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_vline(
    xintercept = median(bat), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_vline(
  #  xintercept = var(bat), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_vline(
    xintercept = max(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_vline(
    xintercept = min(bat), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  geom_hline(
    yintercept = mean(mem), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(mem), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(mem), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(mem), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(mem), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       x = "Power Consumption (uW)",
       y = "Memory Consumption (KB)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Power-Memory3.png", 1000, 700)
qplot(bat, mem, data=data,
) + 
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       x = "Power Consumption (uW)",
       y = "Memory Consumption (KB)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
############ ############ ############


############ ############ ############
############ Power*Time (Energy) - ROW
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Energy0.png", 1000, 700)
qplot(row, eng, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
) +
  geom_hline(
    yintercept = mean(eng), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(eng), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(eng), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(eng), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(eng), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Energy Consumption (w/h)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Energy1.png", 1000, 700)
qplot(row, eng, data=data,
      geom = c("point", "smooth"),
      method = "lm",
      formula = y ~ ns(x,10)
) +
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Energy Consumption (w/h)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Energy2.png", 1000, 700)
qplot(row, eng, data=data
) +
  geom_hline(
    yintercept = mean(eng), colour="#8E44AD", size=2, alpha=0.4
  )+
  geom_hline(
    yintercept = median(eng), colour="#27AE60", size=2, alpha=0.4
  )+
  #geom_hline(
  #  yintercept = var(eng), colour="#CA6F1E", size=2, alpha=0.4
  #) +
  geom_hline(
    yintercept = max(eng), colour="#E74C3C", size=2, alpha=0.3
  ) +
  geom_hline(
    yintercept = min(eng), colour="#E74C3C", size=2, alpha=0.3
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Energy Consumption (w/h)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
png("E:\\Green_Lab\\Charts\\indexed_db_bulk-Energy3.png", 1000, 700)
qplot(row, eng, data=data
  ) +  
  theme(
    plot.background  = element_rect(fill="transparent"),
    panel.background = element_rect(fill="transparent"),
    panel.grid.major = element_line(colour="grey90", size=0.5),
    panel.grid.minor = element_line(colour="grey90", size=0.5),
    axis.line        = element_line(colour="grey30", size=1),
    plot.title = element_text(hjust = 0.5)
  )+
  labs(title = NULL,
       subtitle = NULL,
       y = "Energy Consumption (w/h)",
       x = "Number of Test (1-100)", 
       colour = NULL,
       shape = NULL) +
  geom_point(colour = "grey10", size = 1.5)
dev.off()
#####
