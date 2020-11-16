import hydra
import importlib
import logging
from omegaconf import OmegaConf

@hydra.main(config_path='conf', config_name='conf')
def start(cfg: OmegaConf):

    logger = logging.getLogger()
    logger.setLevel(logging.INFO)

    jobs = cfg.get('jobs', [])
    for job_name in jobs:
        job_inst = cfg.get(job_name)
        if job_inst:
            job = hydra.utils.instantiate(job_inst)
            logging.info(job.__description__)
            job.run()
            logging.info(f'Done')
