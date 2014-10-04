#!/bin/sh

wget -O - http://edition.cnn.com/ASIA/ 2>/dev/null | awk -F= '
{
	if (match($0, "^<h3>TOP ASIA STORIES</h3>.*") > 0)
	{
		getline
		getline
		getline
		getline

		for (i=1; i<=7; i++)
		{
			l=index($0,">");
			tmp=substr($0, l+1);
			r=index(tmp,"<");
			tmp=substr(tmp,1,r-1);
			if (length(tmp) > 32)
				tmp=substr(tmp,1,32)

			cmd="uci set wireless.@wifi-iface[" i "].ssid=\"" tmp "\"";
			print cmd
			system(cmd)
			getline
			getline
			getline
			getline
			getline
		}
		system("uci commit && wifi")
		exit
	}
}
'

#echo "$cnn"

#<h3>TOP ASIA STORIES</h3>^M
#<ul class="cnn_bulletbin">
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/04/world/asia/north-korea-officials-surprise-visit/index.html?hpt=ias_c2" target="_self">North Korean willing to hold talks with South, officials say</a>
#<span class="cnnWOOL"></span>
#</li>
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/04/world/asia/thailand-king-sick/index.html?hpt=ias_c2" target="_self">Thai king hospitalized with high fever </a>
#<span class="cnnWOOL"></span>
#</li>
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/03/world/meast/isis-airstrikes/index.html?hpt=ias_c2" target="_self">Australia joins fight against ISIS in Iraq</a>
#<span class="cnnWOOL"></span>
#</li>
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/02/world/asia/thailand-murders/index.html?hpt=ias_c2" target="_self">Thai police: Burmese men confess to killing British tourists </a>
#<span class="cnnWOOL"></span>
#</li>
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/02/us/u-s-defense-sales-vietnam/index.html?hpt=ias_c2" target="_self">U.S., Vietnam inch toward defense partnership</a>
#<span class="cnnWOOL"></span>
#</li>
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/02/world/asia/north-korea-sohae-satellite-upgrade/index.html?hpt=ias_c2" target="_self">N. Korea completes upgrade for larger rockets</a>
#<span class="cnnWOOL"></span>
#</li>
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/02/world/asia/north-korea-dmz-tunnels/index.html?hpt=ias_c2" target="_self">Is North Korea still digging tunnels to the South? </a>
#<span class="cnnWOOL"></span>
#</li>
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/02/world/asia/afghanistan-troop-attacks/index.html?hpt=ias_c2" target="_self">3 soldiers killed in suicide attack on Afghan troops</a>
#<span class="cnnWOOL"></span>
#</li>
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/01/opinion/hong-kong-silent-majority-chow/index.html?hpt=ias_c2" target="_self">Opinion: Hong Kong's 'silent majority' held hostage </a>
#<span class="cnnWOOL"></span>
#</li>
#<li>
#<span class="cnnWOOL"></span>
#<a href="/2014/10/01/world/asia/japan-volcano/index.html?hpt=ias_c2" target="_self">Avalanche fears halt Japan volcano search</a>
#<span class="cnnWOOL"></span>
#</li>
#</ul>
