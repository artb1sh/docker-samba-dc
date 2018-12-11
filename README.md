# Samba4 AD-DC docker container

This docker container runs Samba4 as an Active Directory Domain Controller.

The first time you start the container, samba-tool will be invoked to set it up using the supplied [environment variables](#environment-variables).
After set is complete, the container will continue starting to get the DC up and running.

The container saves all necessary files within a volume mounted at '/samba'.
See the following examples on how to start/setup the DC. It works best with host networking. With host networking, you'll need to ensure you allow the requisite firewall ports through at the host-level, too.

## Examples 

### Provision a domain

docker-compose.yml

```    environment:
    - SAMBA_DC_REALM=samba.local
    - SAMBA_DC_ADMIN_PASSWD=Secret123
    - SAMBA_DC_ACTION=provision
    - SAMBA_DC_DNS_FORWARDER=1.1.1.1
    - SAMBA_DC_DOMAIN=SAMBA
```
### Join a domain


```    environment:
    - SAMBA_DC_REALM=samba.local
    - SAMBA_DC_ADMIN_PASSWD=Secret123
    - SAMBA_DC_ACTION=join
    - SAMBA_DC_DNS_FORWARDER=1.1.1.1
    - SAMBA_DC_DOMAIN=SAMBA
```

## Environment variables

The following environment variables are all used as part of the DC setup process.
If the DC has been setup, none of htese variables have any effect on the container.

- `SAMBA_DC_REALM` (*required*) The realm (FQDN) for the domain. (e.q. `samba.local`).
- `SAMBA_DC_ACTION` (*required*) The action to take for setup. Must either be `provision` or `join`.
- `SAMBA_DC_MASTER` (*required for joining*) The master DC to join. Should be an IP address.
- `SAMBA_DC_ADMIN_PASSWD` (*required for joining*) The Administrator password for the domain. Will randomly generate if not specified, but *must* be correct to join an existing domain.
- `SAMBA_DC_DNS_FORWARDER` (*optional*) Space separated list of DNS servers to which recursive queries should be forwarded.
- `SAMBA_OPTIONS` (*optional*) Additional options to samba-tool. See man page for available options.
- `SAMBA_DC_DOMAIN` (*optional*) Short name for the domain to create/join. Set to leftmost part of `SAMBA_DC_REALM` if unspecified.
