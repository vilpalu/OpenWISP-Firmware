#
# Copyright (C) 2014 OpenWisp.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openwisp-fw
PKG_VERSION:=3

include $(INCLUDE_DIR)/package.mk


define Package/openwisp-fw-base
	SECTION:=openwisp
	CATEGORY:=OpenWisp
	TITLE:=OpenWisp Firmware base package
	MAINTAINER:=info@openwisp.org
	#this is a meta package suitable for any archs...
	PKG_ARCH:=all
	DEPENDS:=+uhttpd +hostapd +dnsmasq +ntpdate +netcat +tc
	DEPENDS+=+ebtables +tcpdump +ip +kmod-sched +kmod-gre +kmod-ath5k +ppp-mod-pptp
endef

define Package/openwisp-fw
	$(call Package/openwisp-fw-base)
	TITLE:=OpenWisp Firmware standard package
	DEPENDS+=+openvpn-polarssl
endef

define Package/openwisp-fw-mesh
	$(call Package/openwisp-fw)
	TITLE:=OpenWisp Firmware MESH extension
	DEPENDS:=+openwisp-fw +batctl
endef

define Package/openwisp-fw-umts
	$(call Package/openwisp-fw)
	TITLE:=OpenWisp Firmware UMTS extension
	DEPENDS:=+openwisp-fw +comgt
endef


define Package/openwisp-fw-base/description
	 meta package for OpenWisp firmware, this package is a base and small package for small devices

	 This package can use extra file from targz fetched through wget using the $OPENWISP_CONF variable
endef

define Package/openwisp-fw/description
	 meta package for standard OpenWisp firmware, this extend base function with openvpn ability
endef

define Package/openwisp-fw-mesh/description
	 meta package for OpenWisp firmware - MESH
endef

define Package/openwisp-fw-umts/description
	 meta package for OpenWisp firmware - UMTS
endef

define Package/openwisp-fw/config
  source "$(SOURCE)/Config.in"
endef

define Build/Compile
endef

define Package/openwisp-fw-base/install
	$(INSTALL_DIR) $(1)/
	$(CP) -r ./files/* $(1)/

	#unpack external configuration
#	if [ -z "$(OPENWISP_CONF)" ]; then exit 2; fi
#	if [ -f $(OPENWISP_CONF) ]; then tar xvzf $(OPENWISP_CONF) -C $(1)/; fi
	if [ echo $(OPENWISP_CONF) | grep '^http' - ]; then \
		wget $(OPENWISP_CONF) -qO - | tar xvz -C $(1)/; \
	fi

endef

define Package/openwisp-fw-mesh/install
	$(INSTALL_DIR) $(1)/
	#$(CP) -r ./files-mesh/* $(1)/
	#TODO fix owispconfig https://github.com/openwisp/OpenWISP-Firmware/blob/umts-improvement/deploy-firmware.sh#L469
endef

define Package/openwisp-fw-umts/install
	$(INSTALL_DIR) $(1)/
	$(CP) -r ./files-umts/* $(1)/
	#TODO config ttyXXX modem
	#TODO update inittab: https://github.com/openwisp/OpenWISP-Firmware/blob/umts-improvement/deploy-firmware.sh#L460
	#sed -i -e 's/failure 5/failure 4/g' -e 's/interval 1/interval 65535/g' $(1)/etc/ppp/options
endef


$(eval $(call BuildPackage,openwisp-fw-base))
$(eval $(call BuildPackage,openwisp-fw))
$(eval $(call BuildPackage,openwisp-fw-mesh))
$(eval $(call BuildPackage,openwisp-fw-umts))
