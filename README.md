# Zero Watermarking for Vector Geographic Point Data Based on Convex Layers

This repository contains the implementation of a zero watermarking algorithm for vector geographic data, specifically designed for point, polyline, and polygon data. The algorithm provides robust watermarking for geographic information security and is adaptable to sparse and unevenly distributed points.

## Please cite the article

Qifei Zhou, Qiang Zhao, Yingchen She, Wen Yang, Luanyun Hu, Weitong Chen, Na Ren, and Changqing Zhu. 2025. “Zero Watermarking for Vector Geographic Point Data Based on Convex Layers.” Computers & Geosciences 196(2): 105861. doi:[10.1016/j.cageo.2025.105861](https://doi.org/10.1016/j.cageo.2025.105861).

## Table of Contents

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Usage](#usage)
- [Examples](#examples)
- [License](#license)

## Introduction

The zero watermarking algorithm implemented in this repository is developed for secure watermark embedding and detection in vector geographic data. This method leverages convex layers to construct a unique watermark from geographic point data and can also be applied to polyline and polygon data by decomposing them into point sets.

## Requirements

To run this code, you will need MATLAB with the Mapping Toolbox.

## Usage

### Main Script

The main script is `Main.m`, which serves as the entry point for running the watermarking algorithm. This script demonstrates how to read shapefiles, construct a watermark, and evaluate its robustness and uniqueness.

### Provided Data

The repository includes three folders with sample data:
- `data-poi`: Contains point data (e.g., `data-poi/a.shp`).
- `data-polyline-polygon`: Contains polyline data (e.g., river data) and polygon data (e.g., administrative boundaries).
- `data-random`: Contains randomly selected point data for uniqueness testing.

### Running the Main Script

1. Open `Main.m` in MATLAB and run it to execute the following steps:
   - **Construct Zero Watermark**: Constructs a zero watermark from the input shapefile using the `ConstructWatermark` function.
   - **Display Zero Watermark**: Prints the generated zero watermark.
   - **Robustness Test**: Applies a translation attack to the data (translating 100 meters in both x and y directions) and calculates the normalized correlation (NC) between the original and attacked watermarks.
   - **Uniqueness Test**: Constructs watermarks from multiple random shapefiles, calculates NC values between each pair, and performs statistical analysis.

### Functions

- `ConstructWatermark.m`: Constructs the zero watermark using convex layer properties.
- `GetArea.m`: Computes the area of a convex hull formed by points.
- `GetNC2.m`: Calculates the normalized correlation (NC) between two watermarks.
- `GetPoints.m`: Extracts point data from a shapefile.

## Examples

### Example Workflow in `Main.m`

The following is a typical workflow in the main script. In this example:

The script loads a shapefile, generates a watermark, applies a translation attack, and evaluates robustness by calculating the NC between the original and translated watermarks.

It also performs a uniqueness test across random shapefiles and validates the method's applicability to polyline and polygon data.

```matlab
% Load shapefile
s = shaperead("data-poi/a.shp");

% Construct zero watermark
w0 = ConstructWatermark(s);
disp("Zero Watermark: ");
disp(w0);

% Apply translation attack and compute NC
s_translate = s;
for i = 1:numel(s_translate)
    s_translate(i).X = s_translate(i).X + 100;
    s_translate(i).Y = s_translate(i).Y + 100;
end

w_translate = ConstructWatermark(s_translate);
nc = GetNC2(w0, w_translate);
disp("NC after translation attack: ");
disp(nc);

% Uniqueness Test
n = 100;
warr = cell(1, n); % watermark array
for i = 1:n
    fn_tmp = "data-random/a" + i;
    s_tmp = shaperead(fn_tmp);
    warr{i} = ConstructWatermark(s_tmp);
end

% Extension for Polyline and Polygon
fnln = "data-polyline-polygon/River_JiangsuProvince.shp";
sln = shaperead(fnln);
wln = ConstructWatermark(sln);

fnpg = "data-polyline-polygon/AdminDivision_HenanProvince.shp";
spg = shaperead(fnpg);
wpg = ConstructWatermark(spg);

disp("NC with polyline watermark:");
disp(GetNC2(wln, w0));

disp("NC with polygon watermark:");
disp(GetNC2(wpg, w0));
```
## License
This project is licensed under the MIT License. See the LICENSE file for details.
