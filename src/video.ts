import NyaDom from "./libNyaruko_TS/nyadom";
import NyaAs from "./libNyaruko_TS/nyaas";
import NyaCalc, {NyaRect} from "./libNyaruko_TS/nyacalc";
export default class Video {
    videoSize: number[] = [1280, 720];
    video: HTMLVideoElement;

    constructor() {
        this.video = NyaAs.video(NyaDom.byId('bgvideo'));
        this.resize();
    }

    resize() {
        const videoSize: NyaRect = NyaCalc.sizeFill(this.videoSize[0], this.videoSize[1]);
        const px = 'px';
        this.video.style.left = videoSize.x + px;
        this.video.style.top = videoSize.y + px;
        this.video.style.width = videoSize.width + px;
        this.video.style.height = videoSize.height + px;
    }
}