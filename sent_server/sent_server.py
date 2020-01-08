# -*- coding: utf-8 -*-

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import sys
sys.path.append("..")

from bert_serving.server import BertServer
from bert_serving.server.helper import get_run_args


if __name__ == "__main__":
    with BertServer(get_run_args()) as server:
        server.join()
