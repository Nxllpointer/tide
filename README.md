# 🌊 Tide - Notetaking built on free software 🌊
Tired of using proprietary applications to take notes? \
Can't choose between text-based ⌨️ or handwritten 📝 notes? \
Tide has got you covered! Don't compromise - do both!

## Showcase
https://github.com/user-attachments/assets/190de0b5-ae3d-4cfd-8b33-4a41098b0d0b


## How does it work?
Tide is a [neovim](https://neovim.io/) configuration specifically crafted for notetaking,
making use of the [typst](https://github.com/typst/typst) typesetting tool
and [Rnote](https://github.com/flxzt/rnote) for handwritten notes.
Seamless integration between both of these tools is achieved with a modified version
of the typst compiler, which can render Rnote documents like regular images.
Language integration and real-time previewing is provided by [tinymist](https://github.com/Myriad-Dreamin/tinymist).

## Awesome, but how to get started?
🛠️ Tide is built using Nix, ensuring it can run out-of-the-box on any Linux 🐧 machine without issues. \
🔥 A separate Firefox profile also needs to be set up to prevent the preview tabs from mixing with your regular tabs.

1. Installing tide
    1. Install Nix with the [nix-installer](https://github.com/DeterminateSystems/nix-installer) - it's just a single command
    1. Run `nix profile install github:Nxllpointer/tide#tide` This might take a while
1. Setting up Firefox
    1. Open Firefox
    1. Enter `about:profiles` into the address bar
    1. Create a new profile with the name `tide-preview`
    1. Select your old profile as the default profile
1. Creating a tide project (Or use the [tide-example](https://github.com/Nxllpointer/tide-example))
    1. Create a `tideproject.json` file in the root of your project directory
    1. Set the desired and required options ([See the reference](#reference-for-tideprojectjson))
  
## Using tide
After setting up your tide project run `tide` in your project root (The directory with the `tideproject.json`) \
A complete and up-to-date list of keybindings can be found in the [mappings.lua](tide-nvim/lua/tide/mappings.lua) file

- Create a new note
- Start the real-time preview
- Insert rnote documents into the current note


## Reference for tideproject.json
```json
{
  "typst_template_dir": "required<string>",
  "rnote_template_file": "required<string>",
}
```
> All paths are relative to the tideproject.json file!

`typst_template_dir`: Path of the directory to copy for new typst notes \
`rnote_template_file`: Path of the file to copy for new Rnote documents
