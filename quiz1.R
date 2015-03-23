# quiz 1
# 

# Q2
length(twitter)

# Q3
max(nchar(c(blogs, news, twitter)))

# Q4
love <- grep('love', twitter) # 90956
Llove <- grep('[Ll]ove', twitter) # 111221
hate <- grep('hate', twitter)  # 22138
length(love)/length(hate) 

# Q5
grep('biostats', twitter, value = TRUE)

# Q6
grep('A computer once beat me at chetyss, but it was no match for me at kickboxing', twitter)
# 