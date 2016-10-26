
Is Hillary Clinton a Progressive? An Investigation Using Statistical Methods
Posted: 25 Oct 2016 08:00 AM PDT
(This article was first published on R – Curtis Miller's Personal Website, and kindly contributed to R-bloggers)
There was once a time where only the most extreme leftists would accuse Hillary Clinton of not being a true progressive, prior to, say, 2008. Even after 2008, Hillary Clinton was seen as perhaps being a more moderate Democrat, but still, ultimately, a progressive. Republicans certainly would call Clinton a leftist and still continue to believe so.


The opinion on the left, though, seems to have changed. Bernie Sanders’ run for the Presidency turned the floodlights on the influence of big money and the financial sector in legislation. This may be the first time Hillary Clinton’s credentials as a progressive were seriously questioned, since her historical relationship with the financial sector makes many on the left squirm. After this, as Sen. Sanders campaign dragged on and turned into a losing one1, angry Sanders supporters found more reasons to doubt whether Hillary Clinton was a true progressive. This criticism has continued, driven by those cannibalizing Bernie Sanders’ movement such as Jill Stein.

Bernie Sanders is not just a progressive but a socialist (or at least he identifies as one). He may be the most extremist member in the Democratic caucus. Thus, no one should be surprised that Clinton is further to the right than Bernie Sanders, since most people in Congress in particular, and the government in general, are to the right of Bernie Sanders. Does that mean that everyone to the right of Sen. Sanders is not a “true” progressive? I do not believe so. In many areas, Hillary Clinton and Bernie Sanders agreed in at least their official positions, often differing in details but agreeing in spirit or direction. But as often happens in lovers’ quarrels, differences gain a lot of attention and may perhaps become overblown, and people lose sight of what similarities exist.

That’s not to say that we should ignore Clinton’s awkward relationship with the financial sector. Hillary Clinton was the junior senator from New York, and the financial sector represented an important constituency for her. The senior senator from New York, Chuck Schumer, is known for being a Wall Street ally (and if the Democrats retake the Senate, will likely be the Senate Majority Leader). Bill Clinton’s presidency also had a friendly position with Wall Street. Honestly, I do not expect Hillary Clinton’s administration to be tough on the financial sector, which is unfortunate.

That said, in my opinion, this alone does not mean she’s not left of center, let alone that she’s right-wing.

Political ideology is difficult to measure, but a common way to do so is by using a statistic called DW-NOMINATE. These scores use voting records to determine the “distance” between two members of the same chamber of Congress (or anyone we consider a “voter”). Thus, we would expect Bernie Sanders to be distant from Mike Lee but close to Elizabeth Warren. In statistics speak, the method is largely a dimensionality reduction technique. The method computes values along two dimensions, with the first dimension representing a congressman’s score on the liberal-conservative scale, and the second how regional the congressman’s voting pattern is (usually identified with civil rights issues). The first dimension is of particular interest here.

Hillary Clinton was in office from the 107th to the 111th Congress, and the DW-NOMINATE scores of every member of Congress (and the President, interestingly) is available at VoteView.com for those congresses. I downloaded the .dta file for Senators and read it into R:

library(readstata13)
library(magrittr)
senators <- read.dta13("http://voteview.uga.edu/ftp/junkord/Sl01113d21_BSSE.dta")

# This code snatched from here: http://stackoverflow.com/questions/2261079/how-to-trim-leading-and-trailing-whitespace-in-r
# Thanks to user f3lix

# returns string w/o leading whitespace
trim.leading <- function (x)  sub("^\\s+", "", x)

# returns string w/o trailing whitespace
trim.trailing <- function (x) sub("\\s+$", "", x)

# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

senators$name %% trim
A preview is shown below:

head(senators)
##   cong idno state cd  statenm party      name dwnom1 dwnom2 bootse1
## 1    1 4998     1  0  CONNECT  5000   JOHNSON  0.993 -0.118  0.3144
## 2    1 2936     1  0  CONNECT  5000 ELLSWORTH  0.509  0.591  0.1204
## 3    1  507    11  0  DELAWAR  4000   BASSETT  0.119 -0.200  0.0710
## 4    1 7762    11  0  DELAWAR  5000      READ  0.240 -0.296  0.0726
## 5    1 3128    44  0  GEORGIA  4000       FEW -0.557 -0.604  0.1048
## 6    1 3877    44  0  GEORGIA  4000      GUNN -0.095 -0.812  0.0707
##   bootse2  corr12      logl nchoices errors   gmp
## 1  0.2342 -0.1754 -28.02101       82     15 0.711
## 2  0.1229 -0.0631 -21.20176       97     12 0.804
## 3  0.1556  0.2212 -33.94292       90     18 0.686
## 4  0.1120 -0.2312 -31.68506       96     13 0.719
## 5  0.0849 -0.2355 -33.58065       85     27 0.674
## 6  0.1465 -0.1857 -49.87800       83     21 0.548
str(senators)
## 'data.frame':    9063 obs. of  16 variables:
##  $ cong    : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ idno    : int  4998 2936 507 7762 3128 3877 1536 4333 2307 9028 ...
##  $ state   : int  1 1 11 11 44 44 52 52 3 3 ...
##  $ cd      : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ statenm : chr  " CONNECT" " CONNECT" " DELAWAR" " DELAWAR" ...
##  $ party   : int  5000 5000 4000 5000 4000 4000 5000 5000 5000 5000 ...
##  $ name    : chr  "JOHNSON" "ELLSWORTH" "BASSETT" "READ" ...
##  $ dwnom1  : num  0.993 0.509 0.119 0.24 -0.557 ...
##  $ dwnom2  : num  -0.118 0.591 -0.2 -0.296 -0.604 ...
##  $ bootse1 : num  0.3144 0.1204 0.071 0.0726 0.1048 ...
##  $ bootse2 : num  0.2342 0.1229 0.1556 0.112 0.0849 ...
##  $ corr12  : num  -0.1754 -0.0631 0.2212 -0.2312 -0.2355 ...
##  $ logl    : num  -28 -21.2 -33.9 -31.7 -33.6 ...
##  $ nchoices: int  82 97 90 96 85 83 95 97 99 82 ...
##  $ errors  : int  15 12 18 13 27 21 18 31 16 8 ...
##  $ gmp     : num  0.711 0.804 0.686 0.719 0.674 ...
##  - attr(*, "datalabel")= chr ""
##  - attr(*, "time.stamp")= chr "16 Aug 2015 13:43"
##  - attr(*, "formats")= chr  "%8.0g" "%8.0g" "%8.0g" "%8.0g" ...
##  - attr(*, "types")= int  65529 65528 65530 65530 8 65529 14 65527 65527 65527 ...
##  - attr(*, "val.labels")= Named chr  "" "" "" "" ...
##   ..- attr(*, "names")= chr  "" "" "" "" ...
##  - attr(*, "var.labels")= chr  "congress number" "id number (ICPSR and Poole-Rosenthal)" "icspr state code" "congressional district number" ...
##  - attr(*, "version")= int 118
##  - attr(*, "label.table")= list()
##  - attr(*, "expansion.fields")= list()
##  - attr(*, "byteorder")= chr "LSF"
cong identifies the congress, name the name of a member, party the member’s party (100 for Democrats, 200 for Republicans, 328 for independents2), dwnom1 the individual’s first dimension DW-NOMINATE score, and dwnom2 the second dimension DW-NOMINATE score. Below is a plot of each member

library(dplyr)
# devtools::install_github("hadley/ggplot2")
# Development version 2.2.0 used; downloaded October 11
library(ggplot2)
library(gridExtra)
library(ggthemes)
# Adds geom_text_repel, which allows for text labels that don't overlap
# devtools::install_github("slowkow/ggrepel")
# Development version 0.6.2, downloaded October 11
library(ggrepel)

ggplot(senators %>% filter(cong %in% 107:110), aes(x = dwnom1, y = dwnom2)) +
    geom_point(aes(color = as.factor(party))) +
    scale_color_manual(values = c("#148ACC", "#FF000C", "#B5B50E"),
                       labels = c("Democrat", "Republican", "Independent"),
                       name = "Party") +
    geom_point(data = senators %>% filter(cong %in% 107:110 &
                                       (name %in% c("CLINTON", "OBAMA", "SANDERS") |
                                           (dwnom1 > 0 & party == 100))),
               aes(x = dwnom1, y = dwnom2), color = "black", size = 1.5) +
    geom_text_repel(data = senators %>% filter(cong %in% 107:110 &
                                       (name %in% c("CLINTON", "OBAMA", "SANDERS") |
                                           (dwnom1 > 0 & party == 100))),
              aes(x = dwnom1, y = dwnom2, label = name),
              size = 2.5, fontface = "bold") +
    geom_vline(xintercept = 0, color = "dark grey") +
    facet_wrap(~ cong, nrow = 2) +
    xlab("Liberal vs. Conservative") +
    ylab("Regional Identification (Civil Rights Issues)") +
    labs(title = "Ideological Position of Senators",
         subtitle = "For the 107th to 110th Congresses, highlighting persons of interest",
         caption = "Data source: VoteView.com") +
    theme_economist()
## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
## instead
## Warning: `legend.margin` must be specified using `margin()`. For the old
## behavior use legend.spacing
plot of chunk unnamed-chunk-3

The x-axis is particularly interesting in the above chart, and zero represents ideological neutrality. The independent prior to the 110th Congress is Jim Jeffords from Vermont, and in the 110th Congress, the independent is Bernie Sanders (who served in the House of Representatives prior to serving in the Senate).

The above graphic makes it clear that Clinton’s voting record in the Senate while she was there (the 111th Congress is not counted since that was when she became Secretary of State) had much more in common with Democrats than Republicans (compare that to, say, Zell Miller, a true, and perhaps the last, conservative Democrat). In fact, Clinton was very ideologically close to Obama, though neither were quite as radical as Bernie Sanders. One may even conclude that in the Democratic party, Clinton was left-of-center, though close to mainstream Democrats.

Thus, if one judge’s Clinton by her voting record in the Senate and considers the Democratic party to generally be “progressive” (and despite what many supporters of the Green Party may say, I do), then Clinton should be considered “progressive”. Sure, Hillary Clinton is to the right of Bernie Sanders, but for that matter, everyone is (or was) to the right of Bernie Sanders.

So how does this reconcile with the recent portrayals of Clinton as being perhaps Republican-lite? Say, this one:

https://i0.wp.com/policydj.com/sandersrecord.jpg

Well, these sorts of things are easily cherry-picked (two of the items on this list don’t really matter in the grand scheme of things, in my opinion). Here’s my take:

Hillary Clinton, along with many in the Democratic party, voted for the Iraq War. The war was a huge mistake, but that’s easy to see in retrospect. Something to bear in mind when discussing the Iraq War vote is that the intelligence community was agreeing with the claims of tbe Bush administration that Iraq had dangerous weapons. This was wrong and there were reasons to be doubtful even back then; my grandfather, in particular, said even then that there was no way for Iraq to have such weapons, for various reasons. Remember, though, that the claims about Iraqi weapons were coming from trusted sources whose jobs it was to vet the quality of intelligence and determine the truth, no matter which party was in power. Hillary Clinton decided to trust the intelligence community. Unfortunately, that trust was misplaced. We know that… now.
Yes, Clinton voted for the bank bailouts. This was the right thing to do. Economists generally agreed that the bank bailouts were necessary. The problem was not the bailouts per se, but the fact that they were needed at all. The government has allowed the financial sector to become so big, so powerful, and so undisciplined, the bailouts were needed, and that is unfortunate. However, that does not mean the government should allow the economy to burn down in order to discipline the banks, since many more will pay for the banks’ follies than just the bankers.
Regarding the Patriot Act, bear in mind that many Americans supported the Patriot Act and wanted it to continue. It wasn’t until Snowden’s leaks that the general public wanted the Patriot Act tempered, and this lead to an amazing 2015 legislative battle that saw all conventional alliances and battle lines thrown to the wind (libertarian Republican Rand Paul’s filibuster protesting the Patriot Act’s infringement of civil liberties, or the White House begging the Senate to pass the Republican House’s version of the Patriot Act’s extension bill, which did address at least some concerns about the Act’s infringements on civil liberties). Hillary Clinton has not had any bearing on the Patriot Act since becoming Secretary of State, and I appologize for Clinton promoting popular will in supporting it while she was a Senator.

My research on the two remaining points in the above graphic suggest that they are minor differences on issues that, when looked into, don’t matter all that much (it’s easy to make them look more important than they truly are). There are many other graphics like this, but bear in mind that Clinton and Sanders voted together 93% of the time while both were in the Senate, and even if an issue isn’t quite as hot-button as the ones discussed above, that does not mean it is not important.

People have criticized Clinton for changing her position over the years. For example, Clinton opposed gay marriage up until 2013, when she decided to support it. Consider the following graphic, though, using data from Gallup:

library(reshape2)

# Need to set locale for dates to work properly
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
## [1] "C"
marriage <- data.frame("Should be valid" = c(27,35,42,37,42,46,40,40,44,53,48,50,53,53,54,55,60,58,61),
                       "Should not be valid" = c(68,62,55,59,56,53,56,57,53,45,48,48,46,45,43,42,37,40,37),
                       "Survey date" = as.Date(c("17-Mar-96", "09-Feb-99", "04-May-04", "25-Aug-05", "11-May-06", "13-May-07", "11-May-08", "10-May-09", "06-May-10", "08-May-11", "18-Dec-11", "06-May-12", "29-Nov-12", "07-May-13", "14-Jul-13", "11-May-14", "10-May-15", "12-Jul-15", "08-May-16"), format = "%d-%b-%y"))
head(marriage)
##   Should.be.valid Should.not.be.valid Survey.date
## 1              27                  68  1996-03-17
## 2              35                  62  1999-02-09
## 3              42                  55  2004-05-04
## 4              37                  59  2005-08-25
## 5              42                  56  2006-05-11
## 6              46                  53  2007-05-13
mar_plot % melt(id=c("Survey.date"))
names(mar_plot) <- c("Date", "Opinion", "Percent")
levels(mar_plot$Opinion) <- c("Should be valid", "Should not be valid")
head(mar_plot)
##         Date         Opinion Percent
## 1 1996-03-17 Should be valid      27
## 2 1999-02-09 Should be valid      35
## 3 2004-05-04 Should be valid      42
## 4 2005-08-25 Should be valid      37
## 5 2006-05-11 Should be valid      42
## 6 2007-05-13 Should be valid      46
ggplot(mar_plot, aes(x = Date, y = Percent, group = Opinion)) + 
    geom_line(aes(color = Opinion), size = 2) + 
    scale_color_economist() +
    geom_vline(xintercept = as.Date("20-Apr-00", "%d-%b-%y") %>% as.numeric, color = "black", size = 1) +
    geom_text(x = as.Date("20-Apr-00", "%d-%b-%y") %>% as.numeric, y = 40, label = "Clinton supports civil unions", size = 2.5, angle = 90, vjust = 1) +
    geom_vline(xintercept = as.Date("18-Mar-13", "%d-%b-%y") %>% as.numeric, color = "black", size = 1) +
    geom_text(x = as.Date("18-Mar-13", "%d-%b-%y") %>% as.numeric, y = 40, label = "Clinton supports gay marriage", size = 2.5, angle = 90, vjust = 1) +
    labs(title = "Public Support for Gay Marriage",
         subtitle = "With Hillary Clinton's position highlighted",
         caption = "Source: Gallup") +
    theme_economist()
## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
## instead
## Warning: `legend.margin` must be specified using `margin()`. For the old
## behavior use legend.spacing
plot of chunk unnamed-chunk-4

While it is true that Clinton did not support gay marriage per se until relatively recently, most of the country did not, and she supported civil unions for years, which means she has always believed there should be some legal recognition for homosexual relationships. When the general populace changed its mind on the topic, Clinton brought her own position in step as well. I am not bothered by this, and I can’t think of a good reason why anyone would, as it’s really not much of a change in principle.

I am not necessarily upset by a change in position and think the outrage over flip-flopping isn’t necessarily warranted. Why should anyone be committed to a position for the rest of their career, if not their life? That kind of rigid, anti-intellectual, almost tribal mindset produces the kind of partisanship that is destroying our government today. No one knows everything and everyone should be open to new arguments that challenge existing beliefs. Everyone in an argument (or “debate”, if you prefer) should have a set of (reasonable) criteria that, if the opposition satisfactorily addresses, would prompt at least a consideration of a change in opinion; in other words, everyone should allow themselves to change their minds if a “burden of proof” is met. Otherwise, we may as well throw out any hope for the existence of objective truth and compromise, and hope the battle of our tribal egos does not impoverish us, if not destroy us, in the process.

A politician, in addition to a personal responsibility to intellectual freedom, also must consider the will of her constituents. After all, we elect our representatives to act on our behalf. Should we be upset when a long serving politician changes position to be in alignment with the people’s will when that will changes? I see nothing wrong with that.

It is true that flip-flopping on issues may signal a lack of commitment on a topic. When Sean Hannity praises Donald Trump for doing many of the things he criticized Barack Obama for doing he demonstrates that he never really gave those positions any thought (or really anything, for that matter; he truly is Fox’s dumbest anchor). And Trump changes positions on a dime, never acknowledging there ever was a change let alone why it was made. But that doesn’t mean changing position is always bad. We need to know the difference.

To wrap up, while it’s easy for those in out-of-power third parties to criticize Clinton for not being progressive enough, bear in mind that many of them have never been in the positions that Clinton has been in. They have never been involved in so much legislative activity or have had to endure as much scrutiny as Clinton has seen (and John Oliver’s recent take on third party candidates suggests that this lack of attention may have actually helped people like Jill Stein with flimsy solutions to complex problems). Clinton managed to maintain a more leftward stance even while being in power, and this can be shown mathematically. While there are positions she holds that greatly bother me (cough cough finance sector), I believe that she is still a progressive.

sessionInfo()
## R version 3.2.3 (2015-12-10)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows >= 8 x64 (build 9200)
## 
## locale:
## [1] LC_COLLATE=English_United States.1252 
## [2] LC_CTYPE=English_United States.1252   
## [3] LC_MONETARY=English_United States.1252
## [4] LC_NUMERIC=C                          
## [5] LC_TIME=C                             
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] knitr_1.14         RWordPress_0.2-3   reshape2_1.4.1    
##  [4] ggrepel_0.6.2      ggthemes_3.2.0     gridExtra_2.2.1   
##  [7] ggplot2_2.1.0.9001 dplyr_0.5.0        magrittr_1.5      
## [10] readstata13_0.8.5 
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.7        munsell_0.4.3      colorspace_1.2-6  
##  [4] R6_2.1.3           stringr_1.1.0      plyr_1.8.4        
##  [7] tools_3.2.3        grid_3.2.3         gtable_0.2.0      
## [10] DBI_0.5-1          htmltools_0.3.5    yaml_2.1.13       
## [13] lazyeval_0.2.0     assertthat_0.1     digest_0.6.10     
## [16] tibble_1.2         bitops_1.0-6       base64enc_0.1-3   
## [19] RCurl_1.95-4.8     rsconnect_0.4.3    mime_0.5          
## [22] evaluate_0.9       rmarkdown_1.0.9016 labeling_0.3      
## [25] stringi_1.1.1      XMLRPC_0.3-0       scales_0.4.0.9003 
## [28] XML_3.98-1.4       jsonlite_1.0       markdown_0.7.7
1 I voted for Bernie Sanders in the primaries.

2 Other numbers for other political parties are present, but they are not relevant to this discussion; only Democrats, Republicans, and independents were in the Senate in the period considered.
