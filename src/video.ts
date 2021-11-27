import YQ from './yq/yq';
import { YQRect } from './yq/yq';
export default class Video {
    videoSize: number[] = [1280, 720];
    video: HTMLVideoElement;

    constructor() {
        this.video = document.getElementById('bgvideo') as HTMLVideoElement;
        this.resize();
    }

    resize() {
        const videoSize: YQRect = YQ.sizeFill(this.videoSize[0], this.videoSize[1]);
        const px = 'px';
        this.video.style.left = videoSize.x + px;
        this.video.style.top = videoSize.y + px;
        this.video.style.width = videoSize.width + px;
        this.video.style.height = videoSize.height + px;
    }
}