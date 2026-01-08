# SCREENSHOT_GRID

This tool combines multiple screenshots into a single image file.

I made this tool to help me save time when keeping project knowledge organized.
I often find myself taking screenshots to save information, steps, terminal commands etc for a project, and then I end up with all of these information bits spread all over the place.
This tool helps me organize all my scattered screenshots into a single image limitiing the amount of junk files I have to save and dig through to access 

Script runs locally with no installs

---

## What It Does

- Reads screenshots from the `input` folder
- Adds a title at the top
- Combines screenshots into one image
- Supports two layouts:
  - Grid
  - Vertical (scroll-style)
- Saves the final image to the `output` folder

---

## Folder Structure

SCREENSHOT_COMPILER/
├─ input/ (screenshots go here)
├─ output/ (final image is saved here)
├─ tools/ (portable ImageMagick)
├─ compile_grid.bat
└─ README.md

---

## How To Use

1. Place PNG screenshots in the `input` folder.
2. Run `compile_grid.bat`.
3. Enter:
   - Output file name
   - Title
   - Layout (G = Grid, V = Vertical)
4. Find the final image in `output/<file_name>.png`.

---

## Layout Notes

- Grid layout is best for overviews.
- Vertical layout is best for step-by-step guides.
- Screenshot order follows filename order.

---

## Notes

- Runs completely offline.
- Does not modify system files.
- Delete the project folder to remove everything.
