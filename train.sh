export PYTHONPATH = "."

!CUDA_VISIBLE_DEVICES=0 bash data_gen/runs/nerf/run.sh georgia

# dataset is in data/binary/videos/georgia

# Train the Head NeRF
# model and tensorboard will be saved at `checkpoints/<exp_name>`
!CUDA_VISIBLE_DEVICES=0 python tasks/run.py --config=egs/datasets/georgia/lm3d_radnerf_sr.yaml --exp_name=motion2video_nerf/georgia_head --reset

# copy to the output directory
if [[ -z "${AIP_MODEL_DIR}" ]]; then
  cp checkpoints/* ${AIP_MODEL_DIR}/
fi

# Train the Torso NeRF
!CUDA_VISIBLE_DEVICES=0 python tasks/run.py --config=egs/datasets/georgia/lm3d_radnerf_torso_sr.yaml --exp_name=motion2video_nerf/georgia_torso --hparams=head_model_dir=checkpoints/motion2video_nerf/georgia_head --reset

# copy to the output directory
if [[ -z "${AIP_MODEL_DIR}" ]]; then
  cp checkpoints/* ${AIP_MODEL_DIR}/
fi
