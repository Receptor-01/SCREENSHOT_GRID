# SCREENSHOT_GRID

Combine multiple imgs into one

[ImageMagick](https://imagemagick.org/) for image processing.
Insanely powerful image editing tool... f u adobe im still trying to cancel my subscription

---

## What It Does

- Reads screenshots from the `input` folder
- Adds a title at the top
- Combines screenshots into one image
- Supports two layouts:
  - Grid
  - Vertical (scroll-style)
- Saves the final image to the `output` folder



## How To Use
1. Place PNG screenshots in the `input` folder.
2. Run `compile_grid.bat`.
3. Enter:
   - Output file name
   - Title
   - Layout (G = Grid, V = Vertical)
4. Find the final image in `output/<file_name>.png`.



## Layout Notes
- Grid layout = best for overviews.
- Vertical layout = best for step-by-step guides.
- Screenshot order follows filename order.



## Notes
- Runs completely offline.
- Does not modify system files.
- Delete the project folder to remove everything.
