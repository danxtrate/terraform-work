
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

#define the minimum config for the Virtual Cloud Network
resource "oci_core_virtual_network" "PROD" {
  cidr_block = "${var.vcn_cidr}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "PROD"
  defined_tags = {"BUCH_IaaS.PersonalLearning"="DanIstrate"}
}

#define the internet gateway for the VCN
resource "oci_core_internet_gateway" "IG1" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "IG1"
    vcn_id = "${oci_core_virtual_network.PROD.id}"
    defined_tags = {"BUCH_IaaS.PersonalLearning"="DanIstrate"}
}

#define the route table 
resource "oci_core_route_table" "RouteForPROD" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_virtual_network.PROD.id}"
    display_name = "RouteForPROD"
    route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${oci_core_internet_gateway.IG1.id}"
    }
}

resource "oci_core_security_list" "GENERAL_SecList" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "GENERAL_Seclist"
    vcn_id = "${oci_core_virtual_network.PROD.id}"
    egress_security_rules = [{
        destination = "0.0.0.0/0"
        protocol = "6"
    }]
    ingress_security_rules = [{
        tcp_options {
            "max" = 22
            "min" = 22
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },

	{
	protocol = "6"
	source = "${var.vcn_cidr}"
    }]
}

resource "oci_core_subnet" "AD1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}" 
  cidr_block = "${var.AD1_subnet_cidr}"
  display_name = "AD1"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.PROD.id}"
  route_table_id = "${oci_core_route_table.RouteForPROD.id}"
  security_list_ids = ["${oci_core_security_list.GENERAL_SecList.id}"]
  dhcp_options_id = "${oci_core_virtual_network.PROD.default_dhcp_options_id}"
  defined_tags = {"BUCH_IaaS.PersonalLearning"="DanIstrate"}
}