python char_server.py \
  -model_dir ~/pretrained_lm/bert_wwm_chinese/ \
  -ckpt_name bert_model.ckpt \
  -config_name bert_config.json \
  -priority_batch_size 2 \
  -num_worker 1 \
  -http_port 2606 \
  -pooling_strategy NONE \
  -http_max_connect 40 \
  -max_seq_len 35 \
  -no_special_token \
  -cpu \
#  -albert \
