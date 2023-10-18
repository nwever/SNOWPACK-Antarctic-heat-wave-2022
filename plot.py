#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue May 19 09:52:33 2020

@author: Christoph Kittel
@author: Nander Wever

Note: use prepare_MAR_netcdf.sh to download and manipulate the MAR file to provide for a base map before plotting.
"""
import os as os
import xarray as xr
import numpy  as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import matplotlib.colors as colors
from matplotlib import cm
from matplotlib.colors import ListedColormap
import matplotlib.gridspec as gridspec
import numpy.ma as ma 					# masked array
import cartopy.crs as ccrs
import cartopy.feature as cfeature


def cmap_zscore():
    cmap_zscore = cm.get_cmap('RdBu', 256)
    cmap_zscore_mod = cmap_zscore(np.linspace(0, 1, 256))
    cmap_zscore_mod[int(128-(2.*(256/40))):int(128+(2.*(256/40))), :] = np.array([204/256, 204/256, 204/256, 1])
    return ListedColormap(cmap_zscore_mod)


def spcolor(var2D,cmap,bounds):
    norm = mpl.colors.BoundaryNorm(bounds, cmap.N)
    pcol = plt.pcolormesh(x2D+dh, y2D+dh,var2D,cmap=cmap,norm=norm,linewidth=0,rasterized=True)
    pcol.set_edgecolor('face')


def plot_cbar(gs,cmap,bounds,interval=1):
    axb1 = plt.subplot(gs[1])
    norm = mpl.colors.BoundaryNorm(bounds, cmap.N)
    ticks = bounds[0::interval]
    return mpl.colorbar.ColorbarBase(axb1,cmap=cmap,norm=norm,ticks=ticks,extend='both')


def set_fig(dr=0):
    fw=4.72441 # 12 cm in inches 
    left, right, top, bottom = 0.1, 0.6+dr, 0.4, 0.3
    wspace = 0.1
    wcbar = 0.15
    w = (fw-wspace-wcbar-left-right)
    fh = w+top+bottom
    fig = plt.figure(figsize=(fw,fh))
    gs = gridspec.GridSpec(1, 2, width_ratios=[1.,wcbar/w])
    gs.update(left=left/fw,right=1.-right/fw,bottom=bottom/fh,top=1.-top/fh,wspace=wspace/(fw/2))
    plt.clf()
    plt. subplot(gs[0])
    return fig, gs


def plot_graticules():
    x2D, y2D = np.meshgrid(basemap['x'], basemap['y'])
    lon2D=basemap['LON']
    lat2D=basemap['LAT']
    lon2D_out = ma.array(lon2D,mask=np.where((lat2D>=-80.01)&(lon2D>-170),0,1))
    plt.contour(x2D,y2D,lat2D,np.linspace(-80,-50,4),linewidths=0.5,linestyles='--',colors='gray')
    plt.contour(x2D,y2D,lon2D_out,np.linspace(-135,180,8),linewidths=0.5,linestyles='--',colors='gray')


def layout(x2D,y2D,sh2D,lsm2D,ground2D):
    xmin=-2800
    ymin=-2800
    xmax=2800
    ymax=2800

    sh_color = plt.get_cmap('gray')(0.5)
    plt.contour(x2D,y2D,lsm2D,[0.5],linewidths=0.5,colors='k')
    plt.contour(x2D,y2D,sh2D,range(1000,4200,1000),colors=sh_color,linewidths=0.5)

    plt.gca().set_xticklabels([])
    plt.gca().set_yticklabels([])
    
    plt.axis([xmin,xmax,ymin,ymax])

    
def find_closest_value(x, y, data):
    distances_sq = ((data['easting'].values/1000. - x.values) ** 2 + (data['northing'].values/1000. - y.values) ** 2)
    closest_index = np.argmin(distances_sq)
    v_FAC = data.loc[closest_index, 'dFAC_(m)']
    v_FAC_clim = data.loc[closest_index, 'dFAC_clim_(m)']
    v_FAC_clim_sd = data.loc[closest_index, 'dFAC_clim_sd_(m)']
    v_rho_10cm1 = data_rho.loc[closest_index, 'rho1_10cm_(kg/m3)']
    v_rho_10cm2 = data_rho.loc[closest_index, 'rho2_10cm_(kg/m3)']
    v_rho_10cm_clim = data_rho.loc[closest_index, 'rho_10cm_clim_(kg/m3)']
    v_rho_10cm_clim_sd = data_rho.loc[closest_index, 'rho_10cm_clim_sd_(kg/m3)']
    return v_FAC, v_FAC_clim, v_FAC_clim_sd, v_rho_10cm1, v_rho_10cm2, v_rho_10cm_clim, v_rho_10cm_clim_sd
    
   

basemap = xr.open_dataset('./MARcst-AN35km-176x148.nc', decode_times=False)
data = pd.read_csv("./stats.txt", sep=" ", header=0)
data_rho = pd.read_csv("./rho.txt", sep=" ", header=0)

lsm = (basemap['AIS']<1)
ground=(basemap['GROUND']*basemap['AIS']>30)
x2D, y2D = np.meshgrid(basemap['x'], basemap['y'])
sh = basemap['SH']
dh = (basemap['x'].values[0]-basemap['x'].values[1])/2.

# Create an empty array to store the new field
FAC = basemap['AIS'].copy()
FAC_clim = basemap['AIS'].copy()
FAC_clim_sd = basemap['AIS'].copy()
FAC[:] = np.nan
FAC_clim[:] = np.nan
FAC_clim_sd[:] = np.nan
rho_10cm1 = basemap['AIS'].copy()
rho_10cm2 = basemap['AIS'].copy()
rho_10cm_clim = basemap['AIS'].copy()
rho_10cm_clim_sd = basemap['AIS'].copy()
rho_10cm1[:] = np.nan
rho_10cm2[:] = np.nan
rho_10cm_clim[:] = np.nan
rho_10cm_clim_sd[:] = np.nan



# Iterate over x and y and fill the grids for output
for x in basemap['x']:
    for y in basemap['y']:
        fv1, fv2, fv3, rv1, rv2, rv3, rv4 = find_closest_value(x, y, data)
        FAC.loc[{'x': x, 'y': y}] = fv1
        FAC_clim.loc[{'x': x, 'y': y}] = fv2
        FAC_clim_sd.loc[{'x': x, 'y': y}] = fv3
        rho_10cm1.loc[{'x': x, 'y': y}] = rv1
        rho_10cm2.loc[{'x': x, 'y': y}] = rv2
        rho_10cm_clim.loc[{'x': x, 'y': y}] = rv3
        rho_10cm_clim_sd.loc[{'x': x, 'y': y}] = rv4


# Define the projection
proj = ccrs.SouthPolarStereo()

# Define the coordinates
latitude = -66.0333
longitude = 103.55

# Transform the coordinates
xc, yc = proj.transform_point(longitude, latitude, ccrs.PlateCarree())
xc=xc/1000.
yc=yc/1000.

# Dome C coordinates in km:
domec_x=1359.993
domec_y=-894.443


#
# FIGURE 4
#
fig, gs = set_fig()
dataplot= FAC
dataplot=ma.array(dataplot,mask=lsm)

cmap=plt.get_cmap('BrBG')
listB=np.arange(-0.4,0.411,0.05)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([600,2800,-2200,0])
plt.text(1750,200,'Change in Firn Air Content',ha='center',va='top',fontsize='large') #[kg m-2 yr-1]
plt.text(610,200, '(a)',ha='center',va='top',fontsize='large')
plt.plot([2200,2700],[-1900,-1900],lw=3,color='k')
plt.text(2450,-2000,'500 km',va='top',ha='center')

plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-41,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title('m')
cbar.ax.minorticks_off()

fig.savefig('./figs_python/fig4_panel_a.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig4_panel_a.pdf',format='pdf')




fig, gs = set_fig()
dataplot= (FAC - FAC_clim) / (FAC_clim_sd)
dataplot=ma.array(dataplot,mask=lsm)

cmap=cmap_zscore()
listB=np.arange(-20,20.22,1)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([600,2800,-2200,0])
plt.text(1750,200, r'Change in Firn Air Content $Z$-score',ha='center',va='top',fontsize='large')
plt.text(610,200, '(b)',ha='center',va='top',fontsize='large')
plt.plot([2200,2700],[-1900,-1900],lw=3,color='k')
plt.text(2450,-2000,'500 km',va='top',ha='center')

plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-41,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title('-')
cbar.ax.minorticks_off()
fig.savefig('./figs_python/fig4_panel_b.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig4_panel_b.pdf',format='pdf')


os.system("pdfjam ./figs_python/fig4_panel_a.pdf ./figs_python/fig4_panel_b.pdf --nup 2x1 --landscape --papersize '{155mm,300mm}' --outfile ./figs_python/fig4.pdf")













#
# FIGURE 5
#
fig, gs = set_fig()
dataplot= (rho_10cm1 - rho_10cm_clim)
np.set_printoptions(threshold=np.Inf)
dataplot=ma.array(dataplot,mask=lsm)


cmap=plt.get_cmap('PuOr')
listB=np.arange(-200,202,20)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([-2700,2800,-2700,2800])
plt.text(150,3100,'March 14 surface density anomaly',ha='center',va='top',fontsize='large') #[kg m-2 yr-1]
plt.text(-2698,3100, '(a)',ha='center',va='top',fontsize='large')
plt.plot([2100,2600],[-2000,-2000],lw=3,color='k')
plt.text(2350,-2100,'500 km',va='top',ha='center')

plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-95,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title(r"$\mathrm{kg\,m^{-3}}$")
cbar.ax.minorticks_off()
fig.savefig('./figs_python/fig5_panel_a.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig5_panel_a.pdf',format='pdf')




fig, gs = set_fig()
dataplot= (rho_10cm2 - rho_10cm_clim)
np.set_printoptions(threshold=np.Inf)
dataplot=ma.array(dataplot,mask=lsm)

cmap=plt.get_cmap('PuOr')
listB=np.arange(-200,202,20)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([-2700,2800,-2700,2800])
plt.text(150,3100,'March 19 surface density anomaly',ha='center',va='top',fontsize='large') #[kg m-2 yr-1]
plt.text(-2698,3100, '(b)',ha='center',va='top',fontsize='large')
plt.plot([2100,2600],[-2000,-2000],lw=3,color='k')
plt.text(2350,-2100,'500 km',va='top',ha='center')
plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-95,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title(r"$\mathrm{kg\,m^{-3}}$")
cbar.ax.minorticks_off()
fig.savefig('./figs_python/fig5_panel_b.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig5_panel_b.pdf',format='pdf')




fig, gs = set_fig()
dataplot= (rho_10cm1 - rho_10cm_clim) / (rho_10cm_clim_sd)
dataplot=ma.array(dataplot,mask=lsm)

cmap=cmap_zscore()
listB=np.arange(-16,16.22,1)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([-2700,2800,-2700,2800])
plt.text(150,3100, r'March 14 surface density anomaly $Z$-score',ha='center',va='top',fontsize='large')
plt.text(-2698,3100, '(c)',ha='center',va='top',fontsize='large')
plt.plot([2100,2600],[-2000,-2000],lw=3,color='k')
plt.text(2350,-2100,'500 km',va='top',ha='center')
plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-95,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title('-')
cbar.ax.minorticks_off()
fig.savefig('./figs_python/fig5_panel_c.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig5_panel_c.pdf',format='pdf')




fig, gs = set_fig()
dataplot= (rho_10cm2 - rho_10cm_clim) / (rho_10cm_clim_sd)
dataplot=ma.array(dataplot,mask=lsm)

cmap=cmap_zscore()
listB=np.arange(-16,16.22,1)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([-2700,2800,-2700,2800])
plt.text(150,3100, r'March 19 surface density anomaly $Z$-score',ha='center',va='top',fontsize='large')
plt.text(-2698,3100, '(d)',ha='center',va='top',fontsize='large')
plt.plot([2100,2600],[-2000,-2000],lw=3,color='k')
plt.text(2350,-2100,'500 km',va='top',ha='center')
plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-95,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title('-')
cbar.ax.minorticks_off()
fig.savefig('./figs_python/fig5_panel_d.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig5_panel_d.pdf',format='pdf')


os.system("pdfjam ./figs_python/fig5_panel_a.pdf ./figs_python/fig5_panel_b.pdf ./figs_python/fig5_panel_c.pdf ./figs_python/fig5_panel_d.pdf --nup 2x2 --landscape --papersize '{300mm,320mm}' --outfile ./figs_python/fig5.pdf")








#
# FIGURE 5 ZOOM
#
fig, gs = set_fig()
dataplot= (rho_10cm1 - rho_10cm_clim)
np.set_printoptions(threshold=np.Inf)
dataplot=ma.array(dataplot,mask=lsm)


cmap=plt.get_cmap('PuOr')
listB=np.arange(-200,202,20)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([600,2800,-2200,0])
plt.text(1750,200,'March 14 surface density anomaly',ha='center',va='top',fontsize='large') #[kg m-2 yr-1]
plt.text(610,200, '(a)',ha='center',va='top',fontsize='large')
plt.plot([2200,2700],[-1900,-1900],lw=3,color='k')
plt.text(2450,-2000,'500 km',va='top',ha='center')

plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-95,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title(r"$\mathrm{kg\,m^{-3}}$")
cbar.ax.minorticks_off()
fig.savefig('./figs_python/fig5z_panel_a.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig5z_panel_a.pdf',format='pdf')




fig, gs = set_fig()
dataplot= (rho_10cm2 - rho_10cm_clim)
np.set_printoptions(threshold=np.Inf)
dataplot=ma.array(dataplot,mask=lsm)

cmap=plt.get_cmap('PuOr')
listB=np.arange(-200,202,20)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([600,2800,-2200,0])
plt.text(1750,200,'March 19 surface density anomaly',ha='center',va='top',fontsize='large') #[kg m-2 yr-1]
plt.text(610,200, '(b)',ha='center',va='top',fontsize='large')
plt.plot([2200,2700],[-1900,-1900],lw=3,color='k')
plt.text(2450,-2000,'500 km',va='top',ha='center')

plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-95,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title(r"$\mathrm{kg\,m^{-3}}$")
cbar.ax.minorticks_off()
fig.savefig('./figs_python/fig5z_panel_b.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig5z_panel_b.pdf',format='pdf')




fig, gs = set_fig()
dataplot= (rho_10cm1 - rho_10cm_clim) / (rho_10cm_clim_sd)
dataplot=ma.array(dataplot,mask=lsm)

cmap=cmap_zscore()
listB=np.arange(-16,16.22,1)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([600,2800,-2200,0])
plt.text(1750,200, r'March 14 surface density anomaly $Z$-score',ha='center',va='top',fontsize='large')
plt.text(610,200, '(c)',ha='center',va='top',fontsize='large')
plt.plot([2200,2700],[-1900,-1900],lw=3,color='k')
plt.text(2450,-2000,'500 km',va='top',ha='center')
plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-95,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title('-')
cbar.ax.minorticks_off()
fig.savefig('./figs_python/fig5z_panel_c.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig5z_panel_c.pdf',format='pdf')




fig, gs = set_fig()
dataplot= (rho_10cm2 - rho_10cm_clim) / (rho_10cm_clim_sd)
dataplot=ma.array(dataplot,mask=lsm)

cmap=cmap_zscore()
listB=np.arange(-16,16.22,1)
bounds=listB.tolist()
spcolor(dataplot,cmap,bounds)

plot_graticules()
layout(x2D,y2D,sh,lsm,ground)

plt.axis([600,2800,-2200,0])
plt.text(1750,200, r'March 19 surface density anomaly $Z$-score',ha='center',va='top',fontsize='large')
plt.text(610,200, '(d)',ha='center',va='top',fontsize='large')
plt.plot([2200,2700],[-1900,-1900],lw=3,color='k')
plt.text(2450,-2000,'500 km',va='top',ha='center')
plt.scatter(domec_x, domec_y, color='red', s=50)
plt.text(domec_x,domec_y-95,'Dome C',va='top',ha='center',color="red")
cbar = plot_cbar(gs,cmap,bounds,interval=2)
cbar.ax.set_title('-')
cbar.ax.minorticks_off()
fig.savefig('./figs_python/fig5z_panel_d.png',format='PNG', dpi=300)
fig.savefig('./figs_python/fig5z_panel_d.pdf',format='pdf')


os.system("pdfjam ./figs_python/fig5z_panel_a.pdf ./figs_python/fig5z_panel_b.pdf ./figs_python/fig5z_panel_c.pdf ./figs_python/fig5z_panel_d.pdf --nup 2x2 --landscape --papersize '{300mm,320mm}' --outfile ./figs_python/fig5z.pdf")
