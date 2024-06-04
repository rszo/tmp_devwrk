type Props = { title: string; url: string };

export default function BookmarkItem({ title, url }: Props) {
  return (
    <div className="py-1">
      <a href={url} target="_blank" className="text-blue-600 hover:underline">
        {title}
      </a>
    </div>
  );
}
