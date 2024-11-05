disclaimer: very much work in progress

this is my nixos config,
using a flake as the central entrypoint (duh )and home manager as a module, the goal of the system is to :
  - be easy to create new machine-specific configurations, which is why there are many different custom configuration options in main.nix, which are then set in the machine.nix
  - support the easy switching of applications, wallpaper, theme, drivers etc etc through aforementioned custom options
  - nice looking and easily usable 
  - fast to deploy 

i would say that most of these points are decently realised, but there is a lot of cool stuff i still want to implement, namely:
- [ ] wezterm implementation
- [ ] disko
- [ ] agenix
- [ ] cleanup and restructuring
 
also please note that the repo is weird, has quite a few (at least partially unneccisary) abstractions and probably wont make sense to you if you havent gotten as many knocks on the head as i have
huge shoutout to [NotaShelf](https://github.com/NotAShelf) for the help and [ryan4yin](https://github.com/ryan4yin), [minikN](https://github.com/minikN) and [nmasur](https://github.com/nmasur) for inspiration via their repos, aaaand of course all the geniuses who contribute to the nix ecosystem

<3