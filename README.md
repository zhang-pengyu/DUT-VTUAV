# DUT-VTUAV
We release a large-scale benchmark for Visble-thermal UAV Tracking.

# News

* The dataset is available on [VTUAV](https://zhang-pengyu.github.io/DUT-VTUAV/).
* Our paper is accepted by CVPR2022!!

# Main Feature
* **_Large-scale_**: We collected nearly 1.7 million well-aligned RGB-T image pairs with 500 sequences for unveiling the power of RGB-T tracking(the largest RGB-T tracking benchmark so far).
* **_High-diversity_**:13 sub-classes and 15 scenes cross 2 cities.
* **_Multi-task evaluation_**: Our benchmark is designed for evaluating both short-term tracking, long-term tracking and tracking with segmentation.
* **_Hierarchical attribute annotation_**: Sequence-level attribute annotation for 13 typical challenges. Additionally, we provide frame-level attribute for training challenge-aware trackers.

# Results (Files will be comming soon...)
We evaluate both 18 public RGB trackers and 5 RGB-T trackers on the short-term and long-term subsets.

![alt text](https://github.com/zhang-pengyu/DUT-VTUAV/blob/main/figs/RGB_SOTA_ST.pdf)

![alt text](https://github.com/zhang-pengyu/DUT-VTUAV/blob/main/figs/RGB_SOTA_LT.pdf)

# Evaluation toolkit (comming soon...)

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
