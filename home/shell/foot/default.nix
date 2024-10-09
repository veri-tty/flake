{ pkgs, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      font=jetsbrains-mono:size=8      
}
