#!/usr/bin/env Rscript
#  CVE_amplicon.R
#  Copyright 2017- E. Ernestina Godoy Lozano (tinagodoy@gmail.com)
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
########## CVE set amplicon 16 S

metaxa.gg <- read.delim("metaxa.gg.amplicon.tab.sort.cve.cut", header=F)
metaxa.mtx <- read.delim("metaxa.mtx.amplicon.tab.sort.cve.cut", header=F)
metaxa.rdp <- read.delim("metaxa.rdp.amplicon.tab.sort.cve.cut", header=F)
metaxa.silva <- read.delim("metaxa.silva.amplicon.tab.sort.cve.cut", header=F)

parallel.meta.gg <- read.delim("parallel-meta_gg.amplicon.tab.sort.cve.cut", header=F)
parallel.meta.mtx <- read.delim("parallel-meta_mtx.amplicon.tab.sort.cve.cut", header=F)
parallel.meta.rdp <- read.delim("parallel-meta_rdp.amplicon.tab.sort.cve.cut", header=F)
parallel.meta.silva <- read.delim("parallel-meta_silva.amplicon.tab.sort.cve.cut", header=F)

qiime.gg <- read.delim("qiime.gg.amplicon.tab.sort.cve.cut", header=F)
qiime.mtx <- read.delim("qiime.mtx.amplicon.tab.sort.cve.cut", header=F)
qiime.rdp <- read.delim("qiime.rdp.amplicon.tab.sort.cve.cut", header=F)
qiime.silva <- read.delim("qiime.silva.amplicon.tab.sort.cve.cut", header=F)

Spingo.gg <- read.delim("spingo.gg.amplicon.tab.sort.cve.cut", header=F)
Spingo.mtx <- read.delim("spingo.mtx.amplicon.tab.sort.cve.cut", header=F)
Spingo.rdp <- read.delim("spingo.rdp.amplicon.tab.sort.cve.cut", header=F)
Spingo.silva <- read.delim("spingo.silva.amplicon.tab.sort.cve.cut", header=F)

colnames(metaxa.gg)<- c("cov", "epq")
colnames(metaxa.mtx)<- c("cov", "epq")
colnames(metaxa.rdp)<- c("cov", "epq")
colnames(metaxa.silva)<- c("cov", "epq")
colnames(parallel.meta.gg)<- c("cov", "epq")
colnames(parallel.meta.mtx)<- c("cov", "epq")
colnames(parallel.meta.rdp)<- c("cov", "epq")
colnames(parallel.meta.silva)<- c("cov", "epq")
colnames(qiime.gg)<- c("cov", "epq")
colnames(qiime.mtx)<- c("cov", "epq")
colnames(qiime.rdp)<- c("cov", "epq")
colnames(qiime.silva)<- c("cov", "epq")
colnames(Spingo.gg)<- c("cov", "epq")
colnames(Spingo.mtx)<- c("cov", "epq")
colnames(Spingo.rdp)<- c("cov", "epq")
colnames(Spingo.silva)<- c("cov", "epq")


png("CVE_16S_amplicon.png", height = 300*8, width = 300*8, units = 'px', res=300)
plot(metaxa.gg$cov, metaxa.gg$epq,type="l",col="light blue", xlim=c(0,100), ylim=c(0,100), xlab="Coverage", ylab="EPQ", main="Phylum", lwd=2,lty=3)
lines(metaxa.rdp$cov, metaxa.rdp$epq,type="l",col="navy", lwd=2,lty=3)
lines(metaxa.mtx$cov, metaxa.mtx$epq,type="l",col="dodger blue", lwd=2,lty=3)
lines(metaxa.silva$cov, metaxa.silva$epq,type="l",col="turquoise1", lwd=2,lty=3)

lines(parallel.meta.gg$cov, parallel.meta.gg$epq,type="l",col="sandybrown", lwd=2,lty=2)
lines(parallel.meta.silva$cov, parallel.meta.silva$epq,type="l",col="dark green", lwd=2,lty=2)
lines(parallel.meta.rdp$cov, parallel.meta.rdp$epq,type="l",col="lime green", lwd=2,lty=2)
lines(parallel.meta.mtx$cov, parallel.meta.mtx$epq,type="l",col="black", lwd=2,lty=2)


lines(qiime.gg$cov, qiime.gg$epq,type="l",col="orangered", lwd=2)
lines(qiime.mtx$cov, qiime.mtx$epq,type="l",col="gray46", lwd=2)
lines(qiime.rdp$cov, qiime.rdp$epq,type="l",col="hotpink", lwd=2)
lines(qiime.silva$cov, qiime.silva$epq,type="l",col="lemonchiffon3", lwd=2)

lines(Spingo.gg$cov, Spingo.gg$epq,type="l",col="yellow2", lwd=2,lty=4)
lines(Spingo.mtx$cov, Spingo.mtx$epq,type="l",col="purple2", lwd=2,lty=4)
lines(Spingo.rdp$cov, Spingo.rdp$epq,type="l",col="violetred4", lwd=2,lty=4)
lines(Spingo.silva$cov, Spingo.silva$epq,type="l",col="pink", lwd=2,lty=4)

grid(lwd =2, col="gray98")
dev.off()

x <- c(1,2,3,4,5)
y <- c(10,15,20,25,30)

png("legend_amplicon.png", height = 300*6, width = 300*4, units = 'px', res=300)
plot(x,y,  axes = F, ylab="", xlab="", col="white")
legend("bottomright", legend=c("Metaxa2-GG", "Metaxa2-MTX", "Metaxa2-RDP", "Metaxa2-SIL", "Parallel-meta-GG", "Parallel-meta-MTX", "Parallel-meta-RDP", "Parallel-meta-SIL", "QIIME-GG", "QIIME-MTX", "QIIME-RDP", "QIIME-SIL", "SPINGO-GG", "SPINGO-MTX", "SPINGO-RDP", "SPINGO-SIL"), col=c("light blue", "dodger blue", "navy", "turquoise1", "sandybrown", "black", "lime green", "dark green", "orangered", "gray46", "hotpink", "lemonchiffon3", "yellow2", "purple2", "violetred4", "pink"), lty=c(rep(3,4), rep(2,4), rep(1,4), rep(4,4)), cex=1.2, box.lty=1, lwd=3)
dev.off()

