# DUT-VTUAV
We release a large-scale benchmark for Visble-thermal UAV Tracking.

# News

* The dataset is available on [VTUAV](https://zhang-pengyu.github.io/DUT-VTUAV/).
* Our paper is accepted by CVPR2022!!
* Three versions (full dataset, RGB split and mask split) are available. Please refer to our project page.
# Main Feature
* **_Large-scale_**: We collected nearly 1.7 million well-aligned RGB-T image pairs with 500 sequences for unveiling the power of RGB-T tracking(the largest RGB-T tracking benchmark so far).
* **_High-diversity_**:13 sub-classes and 15 scenes cross 2 cities.
* **_Multi-task evaluation_**: Our benchmark is designed for evaluating both short-term tracking, long-term tracking and tracking with segmentation.
* **_Hierarchical attribute annotation_**: Sequence-level attribute annotation for 13 typical challenges. Additionally, we provide frame-level attribute for training challenge-aware trackers.
# Download from google Drive (python and gdown are required)
```
import gdown
url = "https://drive.google.com/drive/folders/1GwYNPcrkUM-gVDAObxNqERi_2Db7okjP?usp=sharing"
gdown.download_folder(url, quiet=False, use_cookies=False)
```
## Results for RGB trackers on short-term subset
![alt text](https://github.com/zhang-pengyu/DUT-VTUAV/blob/main/figs/RGB_SOTA_ST.png)

## Results for RGB trackers on long-term subset
![alt text](https://github.com/zhang-pengyu/DUT-VTUAV/blob/main/figs/RGB_SOTA_LT.png)

## Results for RGB-T trackers on short-term subset
|  | MSR | MPR |
| ------ | ------ | ------ |
| DAFNet | 45.8 | 62.0 |
| ADRNet | 46.6 | 62.2 |
| FSRPN | 54.4 | 65.3 |
| mfDiMP | 55.4 | 67.3 |
| HMFT | 62.7 | 75.8 |
## Results for RGB-T trackers on long-term subset
|  | MSR | MPR |
| ------ | ------ | ------ |
| ADRNet | 17.5 | 23.5 |
| DAFNet | 18.8 | 25.3 |
| FSRPN | 27.2 | 31.5 |
| mfDiMP | 31.4 | 36.6 |
| HMFT | 35.5 | 41.4 |
| HMFT_LT | 46.1 | 53.6 |
# Evaluation toolkit & attribute annotation
The sequence-level attribute annotation can be found in [BaiduDisk(code:h24u)](https://pan.baidu.com/s/1sjufDVycKSg9_bz9jENxiw) and [GoogleDrive](https://drive.google.com/file/d/1tieIXdGvpnF0EChl6ergT4L3nj2mwFQq/view?usp=sharing).\
The evaluation toolkit can be found in [BaiduDisk(code:99j9)](https://pan.baidu.com/s/1vzdsjLP9qWlwFHLBsYMLmQ) and [GoogleDrive](https://drive.google.com/file/d/1B3609O1TUC9WIfNqevKK-OOlGGiJ11m0/view?usp=sharing).
## How to evaluate
Note: The dataset should be extracted into the same folder.
### RGB-T tracker evaluation
* Modify the variable "basePath" in GenerateMat_ST.m and GenerateMat_LT.m and move your results into "BB_results" folder
* run GenerateMat_ST.m and GenerateMat_LT.m to generate the report files for short-term and long-term tracking
* If only overall performance is needed, directly run plot_ST.m and plot_LT.m to generate the MSR and MPR curves.
* If both overall and attribute-based performance are needed, change the "attrDisplays" and run plot_ST.m and plot_LT.m to generate the MSR and MPR curves.

### RGB tracker evaluation
* Modify the variable "basePath" in GenerateMat_ST_RGB_only.m and GenerateMat_LT_RGB_only.m and move your results into "BB_results_RGB" folder
* run GenerateMat_ST_RGB_only.m and GenerateMat_LT_RGB_only.m to generate the report files for short-term and long-term tracking
* If only overall performance is needed, directly run plot_ST_RGB_only.m and plot_LT_RGB_only.m to generate the MSR and MPR curves.
* If both overall and attribute-based performance are needed, change the "attrDisplays" and run plot_ST_RGB_only.m and plot_LT_RGB_only.m to generate the MSR and MPR curves.

# Reference
If you find this benchmark useful, please cite

@InProceedings{Zhang_CVPR22_VTUAV,\
  author = {Zhang Pengyu and Jie Zhao and Dong Wang and Huchuan Lu and Xiang Ruan},\
  title = {Visible-Thermal UAV Tracking: A Large-Scale Benchmark and New Baseline},\
  booktitle = {Proceedings of the IEEE conference on computer vision and pattern recognition},\
  year = {2022}\
}

# Contact
If you have any questions, feel free to contact [me](mailto:pyzhang@mail.dlut.edu.cn).
