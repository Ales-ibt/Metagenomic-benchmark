#!/usr/bin/env Rscript
#  CVE_WMS.R
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
#WMS

clark <- read.delim("clark.WMS.tab.sort.cve.cut", header=F)
kraken <- read.delim("kraken.WMS.tab.sort.cve.cut", header=F)
mocat <- read.delim("mocat.WMS.tab.sort.cve.cut",  header=F)
metaphlan <- read.delim("metaphlan.WMS.tab.sort.cve.cut",  header=F)

metaxa.rdp <- read.delim("metaxa.rdp.WMS.tab.sort.cve.cut", header=F)
metaxa.mtx <- read.delim("metaxa.mtx.WMS.tab.sort.cve.cut", header=F)
metaxa.gg <- read.delim("metaxa.gg.WMS.tab.sort.cve.cut", header=F)
metaxa.silva <- read.delim("metaxa.silva.WMS.tab.sort.cve.cut", header=F)

parallel.meta.mtx <- read.delim("parallel-meta_mtx.WMS.tab.sort.cve.cut", header=F)
parallel.meta.rdp <- read.delim("parallel-meta_rdp.WMS.tab.sort.cve.cut", header=F)
parallel.meta.gg <- read.delim("parallel-meta_gg.WMS.tab.sort.cve.cut", header=F)
parallel.meta.silva <- read.delim("parallel-meta_silva.WMS.tab.sort.cve.cut", header=F)


colnames(clark)<- c("cov", "epq")
colnames(kraken)<- c("cov", "epq")
colnames(mocat)<- c("cov", "epq")
colnames(metaphlan)<- c("cov", "epq")

colnames(metaxa.rdp)<- c("cov", "epq")
colnames(metaxa.mtx)<- c("cov", "epq")
colnames(metaxa.silva)<- c("cov", "epq")
colnames(metaxa.gg)<- c("cov", "epq")

colnames(parallel.meta.gg)<- c("cov", "epq")
colnames(parallel.meta.silva)<- c("cov", "epq")
colnames(parallel.meta.rdp)<- c("cov", "epq")
colnames(parallel.meta.mtx)<- c("cov", "epq")



png("CVE_WMS.png", height = 300*8, width = 300*8, units = 'px', res=300)
plot(clark$cov, clark$epq,type="l",col="purple", xlim=c(0,100), ylim=c(0,100), xlab="Coverage", ylab="EPQ", main="Phylum", lwd=2)
lines(kraken$cov, kraken$epq,type="l",col="deeppink", lwd=2)
lines(mocat$cov, mocat$epq,type="l",col="orange4", lwd=2)
lines(metaphlan$cov, metaphlan$epq,type="l",col="gold", lwd=2)

lines(metaxa.rdp$cov, metaxa.rdp$epq,type="l",col="navy", lwd=2,lty=3)
lines(metaxa.mtx$cov, metaxa.mtx$epq,type="l",col="dodger blue", lwd=2,lty=3)
lines(metaxa.silva$cov, metaxa.silva$epq,type="l",col="turquoise1", lwd=2,lty=3)
lines(metaxa.gg$cov, metaxa.gg$epq,type="l",col="light blue", lwd=2,lty=3)


lines(parallel.meta.gg$cov, parallel.meta.gg$epq,type="l",col="sandybrown", lwd=2,lty=2)
lines(parallel.meta.silva$cov, parallel.meta.silva$epq,type="l",col="dark green", lwd=2,lty=2)
lines(parallel.meta.rdp$cov, parallel.meta.rdp$epq,type="l",col="lime green", lwd=2,lty=2)
lines(parallel.meta.mtx$cov, parallel.meta.mtx$epq,type="l",col="black", lwd=2,lty=2)

grid(lwd =2, col="gray98")
dev.off()

x <- c(1,2,3,4,5)
y <- c(10,15,20,25,30)

png("legend_WMS.png", height = 300*5.5, width = 300*4, units = 'px', res=300)
plot(x,y,  axes = F, ylab="", xlab="", col="white")
legend("bottomright", legend=c("Clark", "Kraken","MOCAT", "Metaphlan", "METAXA2-RDP","METAXA2-MTX","METAXA2-SILVA","METAXA2-GG", "Parallel-Meta-GG", "Parallel-Meta-Silva","Parallel-Meta-RDP" ,"Parallel-Meta-MTX"), col=c("purple", "deeppink","orange4", "gold", "navy","dodger blue","turquoise1","light blue", "sandybrown", "dark green","lime green" ,"black"), lty=c(rep(1,4), rep(3,4), rep(2,4)), cex=1.2, box.lty=1, lwd=3)

dev.off()

