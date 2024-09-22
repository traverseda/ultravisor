# Ultravisor, a Home Assistant Supervisor fork

A fork of home assisant supervisor intended to give users more control.
This is intended for advanced users and is in no way supported by the home assistant project.

 * Run in a docker compose cleanly
 * Disable supervisor auto updates by default
 * Allows installing add-ons when the supervisor is "unhealthy".
 * Allow container to run as unpriviledged
 * Disable hardware management features like networkmanager


## Problems

Entirely unsupported by upstream, and they've shown general hostility to people
changing how home assistant is deployed in the past. The main reason for this
is purpotedly the increased support overhead of dealing with people running things
in weird ways. They would *strongly* prefer you install the home assistant OS or install
supervisor in the specific debian version they support.

They would also strongly prefer it if you kept their software up to date, normally dissallowing
plugin installs and updates if you're not running the latest version.

I don't want to do that because I don't like always-online auto-updating software and
I want to run home assistant supervisor on a touchscreen chromebook with a browser
kiosk, and the debian version they're using isn't really able to run the kiosk.

So, upstream doesn't want you to do this. Don't ask them for support and be prepared
for them to break stuff.

### Known issues

 * If not running as priviledged it can't handle hardware resources, including udev monitoring and
 * It can't view logs for add-ons

## New config options

```
AUTO_UPDATE_SUPERVISOR=False # Audo updating the supervisor will break this
DISABLE_LAST_BOOT_CHECK=True #Goes through the full boot setup when you restart the container
PRETEND_HEALTHY=True #Makes the supervisor pretend to be healthy even when it isn't.
```


## Coding guidelines

We expect upstream to make changes without any care for these features, so try to 
make your changes as shallowly integrated into HA as possible. Instead of using the
supervisor settings system to check env variables, use os.environ directly. Don't
make complicated changes, or if you do need to duplicate the code you're changing
and go down a different branch depending on env variables settings.

Enable all these hacks by default, because if you don't need these horrible hacks
you should be using the official upstream supported home assistant deployments.

## First private cloud solution for home automation

Home Assistant (former Hass.io) is a container-based system for managing your
Home Assistant Core installation and related applications. The system is
controlled via Home Assistant which communicates with the Supervisor. The
Supervisor provides an API to manage the installation. This includes changing
network settings or installing and updating software.

## Installation

Installation instructions can be found at https://home-assistant.io/getting-started.

## Development

For small changes and bugfixes you can just follow this, but for significant changes open a RFC first.
Development instructions can be found [here][development].

## Release

Releases are done in 3 stages (channels) with this structure:

1. Pull requests are merged to the `main` branch.
2. A new build is pushed to the `dev` stage.
3. Releases are published.
4. A new build is pushed to the `beta` stage.
5. The [`stable.json`][stable] file is updated.
6. The build that was pushed to `beta` will now be pushed to `stable`.

[development]: https://developers.home-assistant.io/docs/supervisor/development
[stable]: https://github.com/home-assistant/version/blob/master/stable.json
